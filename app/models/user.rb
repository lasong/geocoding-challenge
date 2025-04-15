class User < ApplicationRecord
  # Use only database_authenticatable from Devise
  devise :database_authenticatable

  has_one :location, dependent: :destroy

  accepts_nested_attributes_for :location
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 4 }
end
