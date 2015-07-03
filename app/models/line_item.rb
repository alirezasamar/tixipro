class LineItem < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :cart
  belongs_to :payment

  validates_presence_of :quantity, :seat_no

  def total_price_after_discount
    @discount = Discount.find_by ticket_id: ticket.id
    if !@discount.nil?
      discount = Discount.find_by ticket_id: ticket.id
      if discount.code == self[:code]
        initial_amount = (ticket.price).to_f
        discounted_total = initial_amount * (discount.discount_percentage.to_f / 100)
        initial_amount - discounted_total
      else
        ticket.price
      end
    else
      ticket.price * quantity
    end
  end

  def total_seats
    (ticket.min_seat_no.to_i..ticket.max_seat_no.to_i).to_a
  end

  def remaining_seats_by_quantity
    line_items = LineItem.where(ticket_id: ticket_id)
    total_taken_seat = line_items.collect { |li| li.valid? ? (li.quantity) : 0 }.sum
    ticket.quantity.to_i - total_taken_seat.to_i
  end

  def all_taken_seat
    line_items = LineItem.all
    line_items.pluck(:seat_no)
  end

  def receipt
    Receipts::Receipt.new(
      id: payment_id,
      product: "Tickets",
      company: {
        name: "Diversecity",
        address: "37 Great Jones\nFloor 2\nNew York City, NY 10012",
        email: "admin@diversecity",
        logo: Rails.root.join("app/assets/images/diversecity.png")
      },
      line_items: [
        ["Date",           payment.created_at.strftime("%e %b %Y %H:%M:%S%p")],
        ["Account Billed", "#{payment.user.name} (#{payment.user.email})"],
        ["Event", self.ticket.event.name],
        ["Tickets Quantity", self.quantity],
        ["Seat No", self.seat_no],
        ["Transaction ID", payment.transaction_id]
      ]
    )
  end
end
