class Post < ApplicationRecord
  # mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :category

  has_many :post_files, dependent: :destroy
  accepts_nested_attributes_for :post_files

  validates :text, presence: true, length: { maximum: 300 }
end
