require 'test_helper'

class NotificationChannelTest < ActionCable::Channel::TestCase
  def test_subscribed
    subscribe(user_id: 1)
    assert subscription.confirmed?
    assert_has_stream "noti_1"
  end

  def test_unsubscribed
    subscribe(user_id: 1)
    unsubscribe
    assert_no_streams
  end
end
