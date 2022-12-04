class Order < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :products

  validates :quantity, numericality: {greater_than: 0, message: "Quantity can't be less than zero"}

  enum status: [:paid, :unpaid, :shipped, :unshipped]

  # def quantity_cannot_be_less_than_zero
  #   if quantity.present? and quantity < 0
  #     errors.add(:quantity, "Quantity can't be less than zero")
  #   end
  # end
end
