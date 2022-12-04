class Store < ApplicationRecord
  belongs_to :user
  has_many :products

  validates :name, presence: true
  validates :name, uniqueness: "There is a store with the same name and this is not allowed"
end
