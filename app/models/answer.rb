class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  validates :text, presence: true
  
  validate :is_wikipedia_title
  validate :does_not_contain_inappropriate_words
  validates :text, presence: true, length: { maximum: 30 }

  validate :is_wikipedia_title
  validate :does_not_contain_inappropriate_words
  validates :text, presence: true, length: { maximum: 30 }

  # WikidediaのAPIから検索サジェスト機能を呼び出す
  def is_wikipedia_title
    page = Wikipedia.find(text)
  end

  # 回答に不適切な単語が含まれていないかチェックする
  # inappropriate_words配列に不適切な単語をリストアップする
  def does_not_contain_inappropriate_words
    inappropriate_words = []
    if inappropriate_words.any? { |word| text.include?(word) }
      errors.add(:text, "送信できません")
    end
  end
end
