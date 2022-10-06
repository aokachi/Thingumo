class AddParentCommentToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :parent_comment, :int
  end
end
