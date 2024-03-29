class LineItem < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :cart
  belongs_to :payment

  validates :quantity, :seat_no, presence: true

  def total_price_after_discount
    discount = Discount.where ticket_id: ticket.id
    if !discount.nil?
      discount = discount.pluck(:code)
      if discount.include?(self[:code])
        percentage = Discount.find_by(code: self[:code])
        initial_amount = (ticket.price).to_f
        discounted_total = initial_amount * (percentage.discount_percentage.to_f / 100)
        initial_amount - discounted_total
      else
        ticket.price
      end
    else
      ticket.price
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

  # for ticket * quantity
  def ticket_quantity
    line_items = LineItem.where(ticket_id: ticket_id)
    total_taken_seat = line_items.collect { |li| li.valid? ? (li.quantity) : 0 }.sum
  end

  def all_taken_seat
    line_items = LineItem.where(ticket_id: ticket_id)
    line_items.pluck(:seat_no)
  end

  def booking_quantity_cannot_be_greater_than_total_quantity
  	if self.quantity.to_i > ticket.quantity.to_i
      errors.add(:quantity, "can't be greater than total quantity")
    end
  end

  def discount_percentage
    Discount.find_by(code: self[:code]).discount_percentage
  end

  def promo_code
    Discount.where(ticket_id: ticket.id).pluck(:code)
  end

  # def receipt
  #   Receipts::Receipt.new(
  #     id: payment_id,
  #     product: "Tickets",
  #     company: {
  #       name: "Diversecity",
  #       address: "Jalan Damansara 10, Malaysia",
  #       email: "admin@diversecity",
  #       logo: Rails.root.join("app/assets/images/diversecity.png")
  #     },
  #     line_items: [
  #       # ["Date",           line.created_at.strftime("%e %b %Y %H:%M:%S%p")],
  #       # ["Account Billed", "#{payment.user.name} (#{payment.user.email})"],
  #       ["Buyer Name", User.find(self.user_id).name],
  #       ["Event", self.ticket.event.name],
  #       ["Tickets Quantity", self.quantity],
  #       ["Seat No", self.seat_no],
  #       ["Transaction ID", self.uid]
  #     ]
  #   )
  # end
end
