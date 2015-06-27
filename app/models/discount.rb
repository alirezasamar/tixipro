class Discount < ActiveRecord::Base
  belongs_to :ticket

  validates_presence_of :ticket_id, :discount_percentage, :code
end
