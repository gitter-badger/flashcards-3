class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :cards

  validates :email, uniqueness: true

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
end
