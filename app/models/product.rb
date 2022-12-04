class Product < ApplicationRecord
  belongs_to :store
  has_and_belongs_to_many :categories
end
