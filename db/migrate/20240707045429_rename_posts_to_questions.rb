class RenamePostsToQuestions < ActiveRecord::Migration[5.2]
  def change
    rename_table :posts, :questions
  end
end
