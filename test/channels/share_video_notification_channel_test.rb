require "test_helper"

class ShareVideoNotificationChannelTest < ActionCable::Channel::TestCase
  test "subscribed method should stream from 'share_notifications'" do
    subscribe

    assert_has_stream "share_notifications"
  end

  test "unsubscribed method should perform cleanup" do
    # Write your test case for the unsubscribed method here
    subscribe
    assert_nothing_raised do
      unsubscribe
    end
  end
end
