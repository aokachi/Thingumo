class ChangeTotalPointsInUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :total_points, :bigint
  end
end
