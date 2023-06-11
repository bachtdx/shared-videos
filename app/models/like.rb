class Like < ApplicationRecord
  belongs_to :shared_video
  belongs_to :user

  after_save :count_like_dislike

  private

  def count_like_dislike
    if self.like
      self.shared_video.increase_video_like
    else
      self.shared_video.increase_video_dislike
    end
  end
end
