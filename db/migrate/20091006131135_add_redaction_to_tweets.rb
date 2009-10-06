class AddRedactionToTweets < ActiveRecord::Migration
  def self.up
    add_column :tweets, :redacted, :boolean, :default => false
    add_column :tweets, :hidden, :boolean, :default => false
  end

  def self.down
    remove_column :tweets, :hidden
    remove_column :tweets, :redacted
  end
end
