class AddPendingToAnswers < ActiveRecord::Migration[5.2]
  def change
    unless column_exists?(:answers, :pending)
      add_column :answers, :pending, :boolean, default: false, null: false
    end
  end
end
