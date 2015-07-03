class LineItem < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :cart
  belongs_to :payment

  def total_price_after_discount
    discount = Discount.find_by ticket_id: ticket.id
    if discount.code == self[:code]
      initial_amount = (ticket.price * quantity).to_f
      discounted_total = initial_amount * (discount.discount_percentage.to_f / 100)
      initial_amount - discounted_total
    else
      ticket.price * quantity
    end
  end

  def total_seats
    (ticket.min_seat_no.to_i..ticket.max_seat_no.to_i).to_a
  end

  def remaining_seats_by_quantity
    line_items = LineItem.all
    total_taken_seat = line_items.collect { |li| li.valid? ? (li.quantity) : 0 }.sum
    ticket.quantity.to_i - total_taken_seat.to_i
  end

  def all_taken_seat
    line_items = LineItem.all
    line_items.pluck(:seat_no)
  end
end
