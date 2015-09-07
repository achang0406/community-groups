class Group < ActiveRecord::Base
  belongs_to :user

  has_many :joins, dependent: :destroy
  has_many :joining_users, through: :joins, source: :users

  validates :name, :description, presence: true
end
