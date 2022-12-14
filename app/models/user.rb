class User < ApplicationRecord
  has_many :stores
  has_many :orders
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable

  validates_associated :stores
  validates_associated :orders
  validates :name, format: {without: /[0-9]/, message: "Numbers are not allowed"}
  validates :name, length: {minimum: 3}
  validates :name, :email, presence: true
  enum role: [:customer, :owner, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :customer
  end
end
