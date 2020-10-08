class Store < ApplicationRecord
  belongs_to :store_manager
  has_many :masseurs, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :store_images, dependent: :destroy
  has_many :messages, dependent: :destroy
  accepts_nested_attributes_for :masseurs
  accepts_nested_attributes_for :store_images
  accepts_nested_attributes_for :plans
  validates :store_name, presence: true
  validates :adress, length: { minimum: 5 }, allow_blank: true
  validates :store_phonenumber, length: { minimum: 10 }, allow_blank: true
  validates :store_description, length: { minimum: 10 }, allow_blank: true
  enum calendar_status: { "released": 0, "private": 1 }, _prefix: true

  scope :categorized, -> (id) { includes(masseurs: :categories).where(categories: { id: id }) }
  scope :active, -> { includes(:store_manager).where.not(store_managers: {order_plan: nil}) }
end
