class Post < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :comment, length: { maximum: 20 }
  validates :point, numericality: true
end
