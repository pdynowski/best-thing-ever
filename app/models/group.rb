class Group < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_secure_password

  has_many :entourages
  has_many :users, through: :entourages
  has_many :votes, through: :users
end
