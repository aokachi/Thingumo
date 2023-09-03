class RenameCommentsToAnswers < ActiveRecord::Migration[5.2]
  def change
    rename_table :comments, :answers
  end
end
