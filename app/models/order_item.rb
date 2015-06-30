class OrderItem < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :ticket_present
  validate :order_present
  validate :seat_present
  validates_uniqueness_of :seat_no, scope: :ticket_id, message: "Seat No: seat is already taken"

  before_save :finalize

  def unit_price
    if persisted?
      self[:unit_price]
    else
      ticket.price
    end
  end

  def total_price
    unit_price * quantity
  end

  private

  def ticket_present
    if ticket.nil?
      errors.add(:ticket, "is not valid or is not active.")
    end
  end

  def order_present
    if order.nil?
      errors.add(:order, "is not a valid order.")
    end
  end

  def seat_present
    if seat_no.nil?
      errors.add(:seat_no, "is not valid or is not active.")
    end
  end


  def finalize
    self[:unit_price] = unit_price
    self[:total_price] = quantity * self[:unit_price]
  end

end
