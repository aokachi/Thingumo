class RemoveImageIdFromPostImages2 < ActiveRecord::Migration[5.2]
  def change
    remove_column :post_images, :image_id
  end
end
