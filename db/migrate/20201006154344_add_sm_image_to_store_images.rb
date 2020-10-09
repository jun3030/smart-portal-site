class AddSmImageToStoreImages < ActiveRecord::Migration[6.0]
  def change
    add_column :store_images, :sm_image, :json
  end
end
