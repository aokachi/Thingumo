class ReCreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.json :images
      t.bigint :user_id
      t.bigint :category_id
      t.bigint :view_count, default: 0
      t.boolean :is_resolved
      t.datetime :confirmed_at
      t.bigint :resolved_user_id
      t.timestamps
    end
  end
end
