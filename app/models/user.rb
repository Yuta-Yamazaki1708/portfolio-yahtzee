class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :icon do |attachable|
    attachable.variant :thumb, resize_to_fill: [50, 50]
  end

  validates :username, presence: true
  validates :password, presence: true, on: :create
end
