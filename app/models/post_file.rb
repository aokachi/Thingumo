class PostFile < ApplicationRecord
  belongs_to :post

  # 画像アップロード
  mount_uploader :image, ImageUploader
end
