class Discount < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :event

  validates_presence_of :ticket_id, :discount_percentage, :code
end
