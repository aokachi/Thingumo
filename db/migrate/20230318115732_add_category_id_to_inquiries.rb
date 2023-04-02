class AddCategoryIdToInquiries < ActiveRecord::Migration[5.2]
  def change
    add_column :inquiries, :category_id, :integer
  end
end
