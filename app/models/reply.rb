class Reply < ApplicationRecord
  belongs_to :store
  belongs_to :user
  belongs_to :message

  validates :reply, presence: true
end
