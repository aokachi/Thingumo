class RenameCommentableToAnswerableInAnswers < ActiveRecord::Migration[5.2]
  def change
    rename_column :answers, :commentable_id, :answerable_id
    rename_column :answers, :commentable_type, :answerable_type
  end
end
