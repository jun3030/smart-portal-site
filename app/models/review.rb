class Review < ApplicationRecord
  belongs_to :user
  belongs_to :store

  validates :title, presence: true,length: { in: 1..30 }
  validates :content, presence: true,length: { in: 1..300 }
  validates :rate, numericality: {less_than_or_equal_to: 5, greater_than_or_equal_to: 1}, presence: true
end
