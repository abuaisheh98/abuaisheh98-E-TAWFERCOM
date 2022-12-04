class Order < ApplicationRecord
  belongs_to :user

  validate :quantity_cannot_be_less_than_zero

  enum status: [:paid, :unpaid, :shipped, :unshipped]

  def quantity_cannot_be_less_than_zero
    if quantity.present? and quantity < 0
      errors.add(:quantity, "Quantity can't be less than zero")
    end
  end
end
