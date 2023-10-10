class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :text, presence: true
  
  validate :is_wikipedia_title
  validate :does_not_contain_inappropriate_words
  validates :text, presence: true, length: { maximum: 30 }

  def is_wikipedia_title
    page = Wikipedia.find(text)
    if page.text.nil?
      errors.add(:text, "送信できません")
    end
  end

  def does_not_contain_inappropriate_words
    inappropriate_words = []
    if inappropriate_words.any? { |word| text.include?(word) }
      errors.add(:text, "送信できません")
    end
  end
end
