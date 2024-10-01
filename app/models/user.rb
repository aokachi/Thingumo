class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy

  has_one_attached :avatar

  attr_accessor :current_password

  # 管理者かどうか返すメソッド
  def admin?
    self.admin
  end

  # ユーザーの持ち点数を返すメソッド
  def award_points(points)
    self.total_points += points
    self.save
  end  
end
