class Prefecture < ApplicationRecord
    has_many :cities, dependent: :delete_all
end
