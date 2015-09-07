class User < ActiveRecord::Base
  has_secure_password

  has_many :groups
  has_many :joins, dependent: :destroy
  has_many :joined_groups, through: :joins, source: :groups

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
end
