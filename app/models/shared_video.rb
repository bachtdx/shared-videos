class SharedVideo < ApplicationRecord
  validates :video_id, :video_title, presence: true
  belongs_to :user
  has_many :likes
  has_many :liked_users, -> { where(likes: { like: true }) }, through: :likes, source: :user
  has_many :disliked_users, -> { where(likes: { like: false }) }, through: :likes, source: :user

  after_save :send_noti_new_video

  def increase_video_like
    self.update(video_like: self.video_like + 1)
  end

  def increase_video_dislike
    self.update(video_dislike: self.video_dislike + 1)
  end

  private

  def send_noti_new_video
    User.is_logined.is_other_me(self.user_id).each do |user|
      NotificationJob.perform_later(self.video_title, user.email)
    end
  end
end
