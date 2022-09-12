class User < ApplicationRecord
  has_secure_token :auth_token
  has_secure_password

  has_many :tasks, dependent: :destroy
end
