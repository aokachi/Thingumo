class CreatePostFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :post_files do |t|
      t.string :image
      t.references :post, foreign_key:true

      t.timestamps
    end
  end
end
