class Api::V1::VideosController < ApplicationController
  include YoutubeHelper

  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 10

    shared_videos = SharedVideo.page(page).per(per_page)
    total_count = SharedVideo.count

    render json: {
             shared_videos: shared_videos,
             total_count: total_count,
             current_page: page,
             per_page: per_page,
           }
  end

  def shared
    video = YoutubeClient.get_video_info(extract_video_id(params[:id]))
    video[:user_id] = session[:user_id]
    if SharedVideo.create!(video)
      render json: { message: "Share video successfully" }, status: :created
    else
      render json: { error: video.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
