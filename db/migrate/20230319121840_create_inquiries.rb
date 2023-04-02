class CreateInquiries < ActiveRecord::Migration[5.2]
  def change
    create_table :inquiries do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.text :text, null: false, limit: 400
      t.references :category, null: false, foreign_key: { to_table: :inquiry_categories }
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
