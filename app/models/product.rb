class Product < ApplicationRecord
  belongs_to :store
  has_and_belongs_to_many :categories

  validates :production_dste, comparison: {greater_than: :expiry_date}
  validate :expiration_date_cannot_be_in_th_past,
           :price_cannot_be_less_than_or_equal_zero,
           :stock_quantity_cannot_be_less_than_zero

  def expiration_date_cannot_be_in_th_past
    if expiry_date.present? and expiry_date < Date.today
      errors.add(:expiry_date, "Can't be in the past")
    end
  end

  def price_cannot_be_less_than_or_equal_zero
    if price.present? and price <= 0
      errors.add(:price, "Can't be less than or equal zero")
    end
  end

  def stock_quantity_cannot_be_less_than_zero
    if stock_quantity.present? and stock_quantity < 0
      errors.add(:stock_quantity, "Can't be less than zero")
    end
  end
end
