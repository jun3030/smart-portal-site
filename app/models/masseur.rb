class Masseur < ApplicationRecord
  belongs_to :store
  has_many :favorites, dependent: :delete_all
  has_many :business_trip_ranges, dependent: :delete_all
  has_many :cities, through: :business_trip_ranges
  accepts_nested_attributes_for :business_trip_ranges, reject_if: :reject_business_trip_range, allow_destroy: true
  has_many :masseur_categories, dependent: :delete_all
  has_many :categories, through: :masseur_categories
  accepts_nested_attributes_for :masseur_categories, reject_if: :reject_masseur_category, allow_destroy: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :masseur_name, presence: true, length: { in: 1..30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 100 }
  validates :adress, length: { in: 5..60 }, allow_blank: true
  validates :phone_number, length: { minimum: 10 }, allow_blank: true
  validates :password, presence: true, length: { minimum: 6 }, allow_blank: true

  # masseur更新時、登録済カテゴリのチェックが外れていた場合、該当するmasseur_categoryを削除
  def reject_masseur_category(attributes)
    attributes.merge!(_destroy: 1) if attributes[:id].present? && attributes[:category_id].blank?
  end
end
