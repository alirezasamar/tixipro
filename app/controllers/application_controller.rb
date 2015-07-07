class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_cart

  before_filter :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to store_path
  end

  private

  # def current_cart
  #   Cart.find_by id: session[:cart_id], expired: false
  # rescue ActiveRecord::RecordNotFound
  #   cart = Cart.create
  #   session[:cart_id] = cart.id
  #   cart
  # end

  # def
  #   !!session[:user_id]
  # end


   def current_cart
     if !session[:cart_id].nil?
       Cart.find_by id: session[:cart_id], expired: false
     else
       cart = Cart.create
       session[:cart_id] = cart.id
       cart
     end
   end



  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :role_id, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:name, :role_id, :email, :password, :password_confirmation) }
  end
end
