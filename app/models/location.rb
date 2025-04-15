class Location < ApplicationRecord
  belongs_to :user

  validates :street, :city, presence: true
end
