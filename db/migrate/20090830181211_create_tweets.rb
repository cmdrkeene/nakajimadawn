class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.text :text
      t.string :from_user
      t.text :profile_image_url
      t.string :source
      t.string :status_id
      t.string :in_reply_to_status_id
      t.time :tweeted_at

      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end
