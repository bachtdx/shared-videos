class Api::V1::VideosController < ApplicationController
  before_action :authenticate_request, except: [:index]
  include YoutubeHelper

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10

    shared_videos = SharedVideo.includes(:user).order(created_at: :desc)
    total_count = shared_videos.length
    video_data = shared_videos.map do |video|
      {
        id: video.id,
        video_title: video.video_title,
        video_embed: video.video_embed,
        shared_by: video.user.email,
        video_like: video.video_like,
        video_dislike: video.video_dislike,
        video_description: video.video_description
      }
    end
    render json: {
      shared_videos: video_data,
      total_count: total_count,
      current_page: page,
      per_page: per_page
    }
  end

  def shared
    video_id = extract_video_id(params[:id])
    video = YoutubeClient.get_video_info(video_id)
    shared_video = current_user.shared_videos.new(video)

    if shared_video.save
      notify_shared_video(shared_video.video_title, current_user.email)
      render json: { message: 'Share video successfully' }, status: :created
    else
      render json: { error: shared_video.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def notify_shared_video(video_title, shared_by)
    NotificationJob.perform_later(video_title, shared_by)
  end
end
