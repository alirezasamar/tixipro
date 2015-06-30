class OrdersController < ApplicationController
  def index
    @my_tickets = OrderItem.where(user_id: current_user.id, paid: true)
  end
end
