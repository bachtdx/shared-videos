require 'test_helper'

class YoutubeHelperTest < ActionView::TestCase
  include YoutubeHelper

  test 'extract_video_id should return video ID' do
    url = 'https://www.youtube.com/watch?v=abc123'
    video_id = extract_video_id(url)
    assert_equal 'abc123', video_id
  end

  test 'extract_video_id should handle short URL' do
    url = 'https://youtu.be/def456'
    video_id = extract_video_id(url)
    assert_equal 'def456', video_id
  end

  test 'extract_video_id should return nil for invalid URL' do
    url = 'https://example.com/video'
    video_id = extract_video_id(url)
    assert_nil video_id
  end
end
