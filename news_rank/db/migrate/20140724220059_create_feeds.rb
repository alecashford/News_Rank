class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :name
      t.text :url
      t.integer :num_subscribers
      t.timestamps
    end
  end
end
