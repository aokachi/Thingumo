class DropQuestionImagesTableAndRemoveImagesFromQuestions < ActiveRecord::Migration[5.2]
  def up
    # 'question_images' テーブルを削除
    drop_table :question_images

    # 'questions' テーブルから 'images' カラムを削除
    remove_column :questions, :images
  end

  def down
    # 'question_images' テーブルを再作成
    create_table :question_images do |t|
      t.references :question, foreign_key: true
      t.string :image

      t.timestamps
    end

    # 'questions' テーブルに 'images' カラムを再追加
    add_column :questions, :images, :json
  end
end