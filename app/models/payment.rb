class Payment < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  belongs_to :cart
  has_many :line_items, :dependent => :destroy

  has_attached_file :qr_code, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment :qr_code, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  # def add_line_items_from_cart(cart)
  #   cart.line_items.each do |item|
  #     item.cart_id = nil
  #     line_items << item
  #   end
  # end


  serialize :notification_params, Hash
  def paypal_url(return_path)
    values = {
        business: "icemission@gmail.com",
        cmd: "_cart",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: id,
        notify_url: "#{Rails.application.secrets.app_host}/hook"
    }

    line_items.each_with_index do |item, index|
      values.merge!({
        "amount_#{index+1}" => item.total_price_after_discount,
        "item_name_#{index+1}" => item.ticket.ticket_type,
        "item_number_#{index+1}" => item.seat_no,
        "quantity_#{index+1}" => item.quantity
      })
    end

    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end


end
