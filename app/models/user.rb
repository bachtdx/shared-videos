class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_many :shared_videos
  has_many :likes

  scope :is_logined, -> { where(is_logined: true) }
  scope :is_other_me, ->(user_id) { where.not(id: user_id) }

  def update_is_logined(logined)
    self.update(is_logined: logined)
  end
end
