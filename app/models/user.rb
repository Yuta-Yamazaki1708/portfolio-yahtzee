class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :icon do |attachable|
    attachable.variant :thumb, resize_to_fill: [50, 50]
    attachable.variant :display, resize_to_fill: [300, 300]
  end

  validates :username, presence: true
  validates :password, presence: true, on: :create

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.username = "ゲスト"
      user.icon.attach(io: File.open(Rails.root.join('app/assets/images/icon.jpg')), filename: 'icon.jpg')
    end
  end
end
