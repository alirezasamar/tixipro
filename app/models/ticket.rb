class Ticket < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  has_many :discounts
  has_many :order_items
end
