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
    session[:order_id] = nil
  end

  # GET /registrations/new
  def new
    @payment = Payment.new
    @order = Order.find_by id: params["order_id"]
    @order_items = current_order.order_items
  end

  # POST /registrations
  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      redirect_to @payment.paypal_url(payment_path(@payment))
    else
      render :new
    end
  end

  protect_from_forgery except: [:hook]
  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    # if status == "Completed"
      @payment = Payment.find params[:invoice]
      @payment.update_attributes notification_params: params, currency_type: params[:mc_currency], transaction_amount: params[:mc_gross], status: status, transaction_id: SecureRandom.hex(10), purchased_at: Time.now

      @order_item = OrderItem.where(order_id: @payment.order_id)
      @order_item.each do |oi|
        oi.update_attributes paid: true, user_id: @payment.user_id
      end

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
      params.require(:payment).permit(:order_id, :user_id)
    end
end
