class User < ActiveRecord::Base
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password

  has_many :votes, dependent: :destroy
end
