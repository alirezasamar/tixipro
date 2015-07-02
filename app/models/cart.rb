class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy

  def total_price
    line_items.collect { |item| item.valid? ? item.total_price_after_discount : 0 }.sum
  end
end
