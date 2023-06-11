class NotificationJob < ApplicationJob
  queue_as :default

  def perform(video_title, shared_by)
    ActionCable.server.broadcast('NotificationChannel', {
                                   video_title: video_title,
                                   shared_by: shared_by
                                 })
  end
end
