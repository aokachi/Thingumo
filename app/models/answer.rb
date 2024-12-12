class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  validates :text, presence: true
  
  validates :text, presence: true, length: { maximum: 30 }
end
