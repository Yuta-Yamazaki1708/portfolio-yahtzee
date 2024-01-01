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
  validate :icon_file_validation, if: :icon_attached?

  def icon_attached?
    icon.attached?
  end

  def icon_file_validation
    unless icon.blob.content_type.in?(%('image/jpg, image/jpeg, image/png'))
      icon.purge
      icon.attach(io: File.open(Rails.root.join('app/assets/images/icon.jpg')), filename: 'icon.jpg')
      errors.add(:icon, "はjpg,jpeg,png形式でアップロードしてください。")
    end
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.username = "ゲスト"
      user.icon.attach(io: File.open(Rails.root.join('app/assets/images/icon.jpg')), filename: 'icon.jpg')
    end
  end
end
