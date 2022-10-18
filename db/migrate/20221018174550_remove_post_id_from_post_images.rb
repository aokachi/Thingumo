class RemovePostIdFromPostImages < ActiveRecord::Migration[5.2]
  def change
    remove_column :post_images, :post_id
  end
end
