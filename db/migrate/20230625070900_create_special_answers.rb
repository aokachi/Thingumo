class CreateSpecialAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :special_answers do |t|
      t.string :content
      t.references :user, foreign_key: true
      t.references :commentable, polymorphic: true
      t.references :post, foreign_key: true
      t.boolean :approval

      t.timestamps
    end
  end
end
