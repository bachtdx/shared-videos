class Like < ApplicationRecord
  belongs_to :shared_video
  belongs_to :user
end
