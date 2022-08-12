class AddReferencesToPosts2 < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :user, null: false, foreign_key: true
  end
end
