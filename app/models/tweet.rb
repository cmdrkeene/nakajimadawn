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
  
  def self.new_from_hash(hash)
    new(:from_user                => hash["user"]["screen_name"],
        :status_id                => hash["id"],
        :tweeted_at               => Time.utc.parse(hash["created_at"]),
        :text                     => hash["text"],
        :source                   => hash["source"],
        :in_reply_to_user_id      => hash["in_reply_to_user_id"],
        :in_reply_to_status_id    => hash["in_reply_to_status_id"],
        :in_reply_to_screen_name  => hash["in_reply_to_screen_name"])
  end
end