class Region < ApplicationRecord
  has_many :prefectures, dependent: :delete_all
end
