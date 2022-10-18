class AddIndexToPostImages < ActiveRecord::Migration[5.2]
  def change
    add_index :post_images, ["post_id"], name: "index_post_images_on_post_id"
  end
end
