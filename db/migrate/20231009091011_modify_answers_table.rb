class ModifyAnswersTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :answers, :answerable_type, :string
    remove_column :answers, :answerable_id, :bigint
    add_column :answers, :is_selected_correct_answer, :boolean, default: false
    add_column :answers, :points_awarded, :bigint
  end
end
