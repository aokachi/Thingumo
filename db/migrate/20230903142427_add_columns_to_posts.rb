class AddColumnsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :is_resolved, :boolean
    add_column :posts, :resolved_user_id, :bigint
  end
end
