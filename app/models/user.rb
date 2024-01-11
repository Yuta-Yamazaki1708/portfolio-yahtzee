require 'open-uri'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

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

  def self.from_omniauth(access_token)
    find_or_create_by(provider: access_token.provider, uid: access_token.uid) do |user|
      user.email = access_token.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = access_token.info.name
      if access_token.info.image
        image_url = access_token.info.image
        image_io = URI.open(image_url)
        user.icon.attach(io: image_io, filename: 'icon.jpg')
      end
    end
  end
end
