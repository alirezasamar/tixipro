class LineItem < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :cart

  validates_uniqueness_of :seat_no, scope: :ticket_id

  def total_price_after_discount
    discount = Discount.find_by ticket_id: ticket.id
    if discount.code == self[:code]
      (ticket.price * quantity).to_f * (discount.discount_percentage.to_f / 100)
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
