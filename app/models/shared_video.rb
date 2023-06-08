class SharedVideo < ApplicationRecord
  validates :video_id, :video_title, presence: true
  belongs_to :user
  has_many :likes
  has_many :liked_users, -> { where(likes: { like: true }) }, through: :likes, source: :user
  has_many :disliked_users, -> { where(likes: { like: false }) }, through: :likes, source: :user
end
