class Category < ApplicationRecord
  has_and_belongs_to_many :products

  validates :name, uniqueness: "The category name must be unique and cannot be duplicated"
end
