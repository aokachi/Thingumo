class AddImageToPostImages < ActiveRecord::Migration[5.2]
  def change
    add_column :post_images, :image, :string
  end
end
