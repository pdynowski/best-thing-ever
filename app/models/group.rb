class Group < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :password, presence: true
  has_secure_password

  has_many :entourages
  has_many :users, through: :entourages
end
