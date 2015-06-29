class Payment < ActiveRecord::Base
  belongs_to :order
  belongs_to :event

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

    order.order_items.each_with_index do |item, index|
      values.merge!({
        "amount_#{index+1}" => item.unit_price,
        "item_name_#{index+1}" => item.ticket.ticket_type,
        "item_number_#{index+1}" => item.id,
        "quantity_#{index+1}" => item.quantity
      })
    end

    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end


end
