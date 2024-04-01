class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :avatar, AvatarUploader

  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }

  has_many :posts, dependent: :destroy
  has_many :answers, dependent: :destroy

  # 管理者かどうか返すメソッド
  class User < ApplicationRecord
    def admin?
      self.admin
    end
  end

  # ユーザーの持ち点数を返すメソッド
  def award_points(points)
    self.total_points += points
    self.save
  end  
end
