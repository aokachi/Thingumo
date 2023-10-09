class DropInquiriesAndRelatedTables < ActiveRecord::Migration[5.2]
  def up
    drop_table :inquiries
    drop_table :inquiry_categories
    drop_table :inquiry_replies
    drop_table :special_answers
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
