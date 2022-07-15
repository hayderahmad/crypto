class User < ApplicationRecord
  has_many :notification_setting
  has_secure_password
  validates :name, presence: true
  validates :email, format: {with: /\S+@\S+/ }, uniqueness: {case_sensitive: false}
end
