class PostIdToQuestionIdInAnswers < ActiveRecord::Migration[5.2]
  def change
    rename_column :answers, :post_id, :question_id
  end
end
