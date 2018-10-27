class User < ApplicationRecord
  has_secure_password

  has_many :data_sets, dependent: :destroy
  has_many :data, dependent: :destroy
  
end
