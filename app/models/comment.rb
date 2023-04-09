class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :content, presence: true
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable  
end
