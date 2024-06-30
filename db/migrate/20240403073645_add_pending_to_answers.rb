class AddPendingToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :pending, :boolean, default: false, null: false
  end
end
