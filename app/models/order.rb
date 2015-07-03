class Order < ActiveRecord::Base
  belongs_to :line_item
end
