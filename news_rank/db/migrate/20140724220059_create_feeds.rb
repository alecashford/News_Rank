class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :name
      t.text :url
      t.text :feedly_feed_id
      t.integer :num_subscribers
      t.timestamps
    end
  end
end
