class ConfirmOrdersController < ApplicationController
  after_action :set_discount

  def show
    @order_items = current_order.order_items
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])

    if @discount.code == params[:code]
      @initial_price = params[:total_price]
      @total_price = @initial_price - number_to_percentage(@discount.discount_percentage)
      @order_item.update_attributes(params[:total_price])
    end

    @order_items = @order.order_items
  end

  def set_discount
    @discount = Discount.find_by_ticket_id(params[:ticket_id])
  end
end
