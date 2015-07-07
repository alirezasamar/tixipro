class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

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

  def cron_job_delete_cart
    cart_time = Time.now - 600
    expired_cart = Cart.where("updated_at < ?", cart_time).where(expired: false)
    expired_cart.destroy_all
  end

end
