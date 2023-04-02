class CreateInquiryCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :inquiry_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
