class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :content, presence: true
  belongs_to :answerable, polymorphic: true
  has_many :answers, as: :answerable
  
  validate :is_wikipedia_title
  validate :does_not_contain_inappropriate_words
  validates :content, presence: true, length: { maximum: 30 }

  def is_wikipedia_title
    page = Wikipedia.find(content)
    if page.text.nil?
      errors.add(:content, "送信できません")
    end
  end

  def does_not_contain_inappropriate_words
    inappropriate_words = []
    if inappropriate_words.any? { |word| content.include?(word) }
      errors.add(:content, "送信できません")
    end
  end
end
