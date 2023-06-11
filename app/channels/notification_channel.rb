class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "NotificationChannel"
  end

  def unsubscribed
    stop_all_streams
  end
end
