class Payment < ActiveRecord::Base
  belongs_to :order
  belongs_to :event

  serialize :notification_params, Hash
  def paypal_url(return_path)
    values = {
        business: "icemission@gmail.com",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: id,
        amount: order.subtotal,
        item_number: order.id,
        notify_url: "#{Rails.application.secrets.app_host}/hook"
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end


end
