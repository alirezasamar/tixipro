class Ticket < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  has_many :discounts, dependent: :destroy
  has_many :line_items, dependent: :destroy

  before_destroy :ensure_not_referenced_by_any_line_item
  # ensure that there are no line items referencing this ticket
  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?
      return true
    else
      errors.add(:base, 'Line Items present' )
      return false
    end
  end

end
