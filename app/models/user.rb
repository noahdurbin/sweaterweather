class User < ApplicationRecord
  has_many :api_keys, as: :bearer

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true

  has_secure_password
end
