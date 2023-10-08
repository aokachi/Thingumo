class AddConfirmedAtToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :confirmed_at, :datetime
  end
end

