class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :name
      t.text :url
      t.text :feedly_feed_id
      t.integer :num_subscribers
      t.text :description
      t.text :topics
      t.timestamps
    end
  end
end
