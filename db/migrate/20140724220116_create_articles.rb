class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.belongs_to :feed
      #Article Metadata
      t.text :canonical_url #Article's full URL
      t.text :site_url #URL for feed website
      t.text :visual_url
      t.integer :visual_height
      t.integer :visual_width
      t.string :author
      t.string :title
      t.string :keywords
      t.text :summary
      t.text :feedly_id
      t.integer :published, :limit => 8

      ##Article Score Data
      t.integer :fb_share_count
      t.integer :fb_like_count
      t.integer :fb_comment_count
      t.integer :twitter_count
      t.integer :reddit_score
      t.integer :reddit_comment_count
      t.integer :calculated_rank
      t.timestamps

    end
  end
end
