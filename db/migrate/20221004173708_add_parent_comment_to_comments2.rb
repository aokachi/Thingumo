class AddParentCommentToComments2 < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :parent_comment, foreign_key: { to_table: :comments }
  end
end
