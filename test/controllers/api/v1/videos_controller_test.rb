require 'test_helper'

class Api::V1::VideosControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @token = JwtService.encode(user_id: @user.id)
    @video_id = 'v_rVbeC6KEg'
    @video_info = {
      'video_title' => 'Sample Video',
      'video_description' => 'This is a sample video',
      'video_embed' => "https://www.youtube.com/embed/#{@video_id}",
      'video_like' => 10,
      'video_dislike' => 2,
      'user_id' => @user.id,
      'video_id' => @video_id
    }

    # Set current user and session for authentication
    # @controller.instance_variable_set(:@current_user, @user)
    @request.session[:user_id] = @user.id
  end

  test 'should get index' do
    @request.headers['Authorization'] = "Bearer #{@token}"
    @user.shared_videos.delete_all
    @user.shared_videos.create!(@video_info)
    get :index, params: { page: 1, per_page: 10 }

    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 3, json_response['shared_videos'].size
    assert_equal @video_info['video_title'], json_response['shared_videos'].first['video_title']
    assert_equal 3, json_response['total_count']
    assert_equal '1', json_response['current_page']
    assert_equal '10', json_response['per_page']
  end

  test 'should share video successfully' do
    @request.headers['Authorization'] = "Bearer #{@token}"
    post :shared, params: { id: "https://www.youtube.com/watch?v=#{@video_id}" }

    assert_response :created
    json_response = JSON.parse(response.body)
    assert_equal 'Share video successfully', json_response['message']
  end

  test 'should share video error case video id invalid' do
    @request.headers['Authorization'] = "Bearer #{@token}"
    post :shared, params: { id: 'https://www.youtube.com/watch?v=1' }

    assert_response :unprocessable_entity
    json_response = JSON.parse(response.body)
    assert_equal ["Video can't be blank", "Video title can't be blank"], json_response['error']
  end
end
