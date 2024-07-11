class RenamePostImagesToQuestionImages < ActiveRecord::Migration[5.2]
  def change
    if table_exists?(:post_images)
      rename_table :post_images, :question_images
    end

    if column_exists?(:question_images, :post_id)
      rename_column :question_images, :post_id, :question_id
    end

    if index_exists?(:question_images, :question_id, name: "index_post_images_on_post_id")
      remove_index :question_images, name: "index_post_images_on_post_id"
    end
    if index_exists?(:question_images, :question_id, name: "index_post_images_on_post_id")
      add_index :question_images, :question_id, name: "index_question_images_on_question_id"
    end
  end
end
