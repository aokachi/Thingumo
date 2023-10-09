class ReCreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.text :text
      t.bigint :user_id
      t.bigint :post_id
      t.boolean :is_selected_correct_answer, default: false
      t.boolean :points_awarded
      t.timestamps
    end
  end
end
