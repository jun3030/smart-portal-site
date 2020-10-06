class StoreImage < ApplicationRecord
  belongs_to :store
  mount_uploaders :store_image, StoreImageUploader
end
