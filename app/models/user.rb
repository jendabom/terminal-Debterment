class User < ApplicationRecord
  has_many :debts
  has_many :expenses
  has_many :incomes
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
end
