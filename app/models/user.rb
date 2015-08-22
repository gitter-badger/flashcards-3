class User < ActiveRecord::Base
  has_many :cards

  validates :email, :password, presence: true
  validates :email, uniqueness: true
end
