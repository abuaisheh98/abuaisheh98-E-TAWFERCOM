class Product < ApplicationRecord
  belongs_to :store
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :orders

  #validates :production_dste, comparison: {greater_than: :expiry_date}
  validate :expiration_date_cannot_be_in_th_past
  validates :price, numericality: {greater_than: 0, message: "Can't be less than or equal zero"}
  validates :stock_quantity, numericality: {greater_than_or_equal_to: 0, message: "Can't be less than zero"}

  def expiration_date_cannot_be_in_th_past
    if expiry_date.present? and expiry_date < Date.today
      errors.add(:expiry_date, "Can't be in the past")
    end
  end
end
