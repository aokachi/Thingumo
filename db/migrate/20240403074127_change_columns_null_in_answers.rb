class ChangeColumnsNullInAnswers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :answers, :text, false
    change_column_null :answers, :user_id, false
    change_column_null :answers, :post_id, false
    change_column_null :answers, :is_selected_correct_answer, false
    change_column_null :answers, :points_awarded, false
  end
end
