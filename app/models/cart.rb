class Cart < ActiveRecord::Base
  has_many :line_items

  # def add_ticket(ticket_id)
  #   current_item = line_items.where(ticket_id: ticket_id).first
  #   if current_item
  #     current_item.quantity += 1
  #   else
  #     current_item = line_items.build(ticket_id: ticket_id)
  #   end
  #
  #   current_item
  # end

  def add_ticket(ticket_id)
    # current_item = line_items.where(ticket_id: ticket_id).first

    @ticket_quantity = self[:quantity].to_i

    @ticket_quantity.each do |tq|
      line_items.build(ticket_id: ticket_id)
    end
  end

  def total_price
    line_items.collect { |item| item.valid? ? item.total_price_after_discount * item.quantity : 0 }.sum
  end

end
