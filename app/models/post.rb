class Post < ApplicationRecord
  mount_uploaders :images, ImageUploader
  
  belongs_to :user
  belongs_to :category

  # has_many :post_images, dependent: :destroy
  # accepts_nested_attributes_for :post_images, allow_destroy: true

  has_many :answers, dependent: :destroy
  has_many :special_answers

  #has_many :post_files, dependent: :destroy
  # accepts_nested_attributes_for :post_files

  validates :text, presence: true, length: { maximum: 300 }

  # def user
    # return User.find_by(id: self.user_id)
  # end
end
