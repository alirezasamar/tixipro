class LineItem < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :cart

  def total_price_after_discount
    discount = Discount.find_by ticket_id: ticket.id
    if discount.code == self[:code]
      (ticket.price * quantity).to_f * (discount.discount_percentage.to_f / 100)
    else
      ticket.price * quantity
    end
  end

  def seats
   ticket.min_seat_no.to_i..ticket.max_seat_no.to_i
  end

  def remaining_seats
    1..ticket.quantity.to_i
  end

end
