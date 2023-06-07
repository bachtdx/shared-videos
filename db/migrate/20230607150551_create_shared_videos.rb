class CreateSharedVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :shared_videos do |t|
      t.integer :user_id
      t.string :video_id
      t.string :video_title
      t.text :video_description
      t.string :video_embed
      t.integer :video_like
      t.integer :video_dislike

      t.timestamps
    end
  end
end
