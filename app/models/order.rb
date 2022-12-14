class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items
  #has_and_belongs_to_many :products

  validates :quantity, numericality: {greater_than: 0, message: "Quantity can't be less than zero"}
  enum status: [:paid, :unpaid, :shipped, :unshipped]

end
