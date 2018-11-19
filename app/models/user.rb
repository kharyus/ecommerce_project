class User < ApplicationRecord
  belongs_to :province
  
  #validates :password, confirmation: true # This breaks everything
  validates :username, :password_hash, :name, :address, :province_id, :email, presence: true

  validates :email, uniqueness: true

end
