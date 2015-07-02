class LineItem < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :cart
end
