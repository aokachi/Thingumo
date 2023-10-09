class Post < ApplicationRecord
  mount_uploaders :images, ImageUploader
  
  belongs_to :user
  belongs_to :category

  # has_many :post_images, dependent: :destroy
  # accepts_nested_attributes_for :post_images, allow_destroy: true

  has_many :answers, dependent: :destroy

  #has_many :post_files, dependent: :destroy
  # accepts_nested_attributes_for :post_files

  validates :text, presence: true, length: { maximum: 300 }

  def mark_as_resolved(user_id)
    self.is_resolved = 1
    self.resolved_user_id = user_id
    self.save
  end  
end
