class SharedVideo < ApplicationRecord
    validates :video_id, :video_title, presence: true
    belongs_to :user
end
