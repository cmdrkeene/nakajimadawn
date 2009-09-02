class Tweet < ActiveRecord::Base
  validates_presence_of :text
  validates_presence_of :from_user
  validates_presence_of :source
  validates_presence_of :status_id
  validates_presence_of :tweeted_at  
  validates_uniqueness_of :status_id, :message => 'Twitter status_id id has already been taken', :if => :status_id?
  validates_numericality_of :status_id, :if => :status_id?
  validates_numericality_of :in_reply_to_status_id, :if => :in_reply_to_status_id?
  validates_numericality_of :in_reply_to_user_id, :if => :in_reply_to_user_id?

  # Find tweets from 12am to 6am, local time
  named_scope :dawn, lambda {|from_user|
    midnight = Time.now.at_midnight.utc.hour
    {:conditions => ["from_user = ?
                     AND date_part('hour', tweeted_at) >= ? 
                     AND date_part('hour', tweeted_at) < ?",
                     from_user, midnight, midnight + 6]}
  }
  
  def self.newest
    first(:order => 'tweeted_at DESC')
  end
  
  def self.new_from_hash(hash)
    new(:from_user                => hash["user"]["screen_name"],
        :status_id                => hash["id"],
        :tweeted_at               => Time.parse(hash["created_at"]).utc,
        :text                     => hash["text"],
        :source                   => hash["source"],
        :in_reply_to_user_id      => hash["in_reply_to_user_id"],
        :in_reply_to_status_id    => hash["in_reply_to_status_id"],
        :in_reply_to_screen_name  => hash["in_reply_to_screen_name"])
  end  
end