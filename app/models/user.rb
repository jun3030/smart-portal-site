class User < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :reviews
  has_many :social_profiles, dependent: :destroy
  has_many :messages, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :omniauthable, omniauth_providers: %i[line google]

  enum gender: { "male": 0, "female": 1, "other": 2 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: { in: 1..30 }
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: 6 } ,allow_nil: true
  validates :address, presence: true, length: { in: 5..60 }
  validates :gender, presence: true
  validates :nickname, length: { in: 1..30 }, allow_blank: true

  protected

  def social_profile(provider)
    social_profiles.select{ |sp| sp.provider == provider.to_s }.first
  end
end
