class User < ApplicationRecord
  has_many :favorite, dependent: :destroy
  has_many :review
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum gender: { "男性": 1, "女性": 2, }
end
