class AddQrCodeToPayment < ActiveRecord::Migration
  def change
    add_attachment :payments, :qr_code
  end
end
