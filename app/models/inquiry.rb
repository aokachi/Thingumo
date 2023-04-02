class Inquiry < ApplicationRecord
  belongs_to :category, class_name: 'InquiryCategory'
  belongs_to :user

  validates :text, length: { maximum: 400 }
end
