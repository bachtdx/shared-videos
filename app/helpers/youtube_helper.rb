module YoutubeHelper
  def extract_video_id(url)
    video_id = nil

    # Kiểm tra xem URL có chứa video ID không
    if url.include?("youtube.com") || url.include?("youtu.be")
      # Trường hợp URL có dạng 'youtube.com/watch?v=VIDEO_ID' hoặc 'youtu.be/VIDEO_ID'
      query_params = URI.parse(url).query
      video_id = Rack::Utils.parse_nested_query(query_params)["v"] if query_params.present?
      video_id ||= url.split("/").last if url.include?("youtu.be")
    end

    video_id
  end
end
