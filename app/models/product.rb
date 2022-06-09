class Product < ApplicationRecord
  validates :title, :description, :image_url, presence: true # Validates that the fields are present.
  validates :price, numericality: {greater_than_or_equal_to: 0.01}  # Validates that the price is greater than 0.
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
end
