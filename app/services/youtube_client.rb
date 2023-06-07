require 'google/apis/youtube_v3'
class YoutubeClient

    def self.get_video_info(video_id)
        youtube = Google::Apis::YoutubeV3::YouTubeService.new
        youtube.key = 'AIzaSyAoSbAK74MFkV74q0g60E5qOiyjYsHfAHU'
        video = youtube.list_videos('snippet', id: video_id).items.first
        return nil unless video

        shared_video = {
            user_id: nil,
            video_id: video_id,
            video_title: video.snippet.title,
            video_description: video.snippet.description,
            video_embed: "https://www.youtube.com/embed/#{video_id}",
            video_like: 0,
            video_dislike: 0
        }
    end

end    