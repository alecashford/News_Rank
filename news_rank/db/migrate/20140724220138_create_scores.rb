class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
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
