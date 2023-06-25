class SpecialAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :content, presence: true
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  
  validate :does_not_contain_inappropriate_words
  validates :content, presence: true, length: { maximum: 30 }

  def does_not_contain_inappropriate_words
    inappropriate_words = []
    if inappropriate_words.any? { |word| content.include?(word) }
      errors.add(:content, "送信できません")
    end
  end
end
