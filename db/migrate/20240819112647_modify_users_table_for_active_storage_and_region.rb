class ModifyUsersTableForActiveStorageAndRegion < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :avatar, :string
    add_column :users, :region, :string
  end
end
