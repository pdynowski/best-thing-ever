class User < ActiveRecord::Base
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password

  has_many :votes, dependent: :destroy
  has_many :entourages
  has_many :groups, through: :entourages
end
