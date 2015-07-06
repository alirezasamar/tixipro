class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
     respond_to do |format|
       format.pdf {
         send_data @line_item.receipt.render,
           filename: "#{@line_item.created_at.strftime("%Y-%m-%d")}-diversecity-ticket.pdf",
           type: "application/pdf",
           disposition: :inline
       }
     end
   end


  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  def my_tickets
    if current_user.curator? || current_user.admin?
      @my_tickets = LineItem.where user_id: current_user.id
    else
      @my_tickets = LineItem.joins(:payment).where(payments: { user_id: current_user })
    end
  end

  def special_checkout
    @line_items = current_cart.line_items

    @line_items.each do |li|
      li.update_attributes special_checkout: true, user_id: current_user.id
    end

    current_cart.update_attributes expired: true
    session[:cart_id] = nil

    redirect_to my_tickets_path, notice: 'Ticket was successfully bought through special checkout'
  end

  # def promo
  #   @cart = current_cart
  #   @line_item = LineItem.where(cart: @cart.id, id: self_id)
  #
  #   @line_item.update_attributes code: params[:code]
  #   redirect_to @line_item.cart
  #   # ticket = Ticket.find(params[:ticket_id])
  #   #
  #   # discount = Discount.find_by ticket_id: ticket.id
  #   # if discount.code == params[:code]
  #   #   asd
  #   #   (ticket.price * quantity).to_f * (discount.discount_percentage.to_f / 100)
  #   # else
  #   #   ticket.price * quantity
  #   # end
  #
  # end

  # POST /line_items
  # POST /line_items.json
  def create
    @cart = current_cart
    @seating = Ticket.find(params[:line_item][:ticket_id]).event
    @ticket = Ticket.find(params[:line_item][:ticket_id])

    # @run = LineItem.new(params[:run])
    # @tape_ids = @run.add_ticket(params[:run][:tapes])

    # if !@seating.free_seating?
      # @line_item = @cart.add_ticket(@ticket.id)
    # else

    @quantity = (params[:line_item][:quantity]).to_i
    @quantity.times do
      @uid = SecureRandom.hex(10)
      @line_item = @cart.line_items.build(ticket: @ticket, uid: @uid)
    # end
      @line_item.save
    end

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart, notice: 'Ticket was successfully added to your cart.' }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item.cart, notice: 'Ticket was successfully updated in your cart.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { redirect_to @line_item.cart, alert: 'Seat already taken' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to @line_item.cart, notice: 'Ticket was successfully removed from your cart.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:ticket_id, :cart_id, :quantity, :code, :seat_no, :uid)
    end
end
