class Food < ApplicationRecord
  belongs_to :category

  validates :name, :price, :category_id, presence: true

  mount_uploader :image, ImageUploader
end
