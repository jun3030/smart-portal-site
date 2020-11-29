class Message < ApplicationRecord
  belongs_to :store
  belongs_to :user
  has_many :replies, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }
end
