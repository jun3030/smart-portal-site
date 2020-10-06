class StoreImage < ApplicationRecord
  belongs_to :store
  mount_uploaders :store_image, StoreImageUploader
  mount_uploaders :sm_image, SmImageUploader
end
