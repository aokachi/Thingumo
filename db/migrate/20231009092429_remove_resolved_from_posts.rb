class RemoveResolvedFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :resolved
  end
end
