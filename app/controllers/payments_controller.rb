class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  # GET /registrations
  def index
    @payments = Payment.all
  end

  # GET /registrations/1
  def show
    @qr = RQRCode::QRCode.new( @payment.transaction_id, size: 4, level: :h).to_img.resize(200, 200).to_data_url
    @payment.update_attributes qr_code: @qr

    session[:cart_id] = nil
  end

  # GET /registrations/new
  def new
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to store_url, :notice => "Your cart is empty"
      return
    end
    @payment = Payment.new
  end

  # POST /registrations
  def create
    @cart = current_cart
    cart = Cart.find(current_cart.id)

    @line_item = Payment.create!(cart: current_cart, user: current_user)
    @payment = Payment.find_by cart_id: current_cart.id

    @li = LineItem.where(cart_id: @payment.cart_id)
    @li.each do |oi|
      oi.update_attributes payment_id: @payment.id
    end

    redirect_to @payment.paypal_url(payment_path(@payment))

  end

  protect_from_forgery except: [:hook]
  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    # if status == "Completed"
      @payment = Payment.find params[:invoice]
      @payment.update_attributes notification_params: params, currency_type: params[:mc_currency], transaction_amount: params[:mc_gross], status: status, transaction_id: SecureRandom.hex(10), purchased_at: Time.now
      #
      # @line_item = LineItem.where(cart_id: @payment.cart_id)
      # @line_item.each do |oi|
      #   oi.update_attributes paid: true, user_id: @payment.user_id
      # end

      @user = User.find(@payment.user_id)

      TicketMailer.purchase_email(@user).deliver_now!
    # end
    render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:order_id, :user_id, :cart_id)
    end
end
