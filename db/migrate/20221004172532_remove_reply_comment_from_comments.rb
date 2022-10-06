class RemoveReplyCommentFromComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :reply_comment
  end
end
