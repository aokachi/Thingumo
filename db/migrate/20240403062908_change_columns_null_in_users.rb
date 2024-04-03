class ChangeColumnsNullInUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :name, false
    change_column_null :users, :email, false
    change_column_null :users, :sex, false
    change_column_null :users, :birthday, false
    change_column_null :users, :total_points, false
    change_column_null :users, :admin, false
  end
end
