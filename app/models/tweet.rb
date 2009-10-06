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

  named_scope :dawn, :conditions => [
    "to_number(to_char(tweeted_at, 'HH24MI'), '9999') >= ? AND
     to_number(to_char(tweeted_at, 'HH24MI'), '9999') <= ?",
    400, # midnight EST in UTC
    1000 # 6am EST in UTC
  ]
  named_scope :from_user, lambda do |from_user|
    {:conditions => {:from_user => from_user}}
  end
  named_scope :hidden, :conditions => {:hidden => true}
  named_scope :visible, :conditions => {:hidden => false}

  def self.newest
    first(:order => 'tweeted_at DESC')
  end

  def self.new_from_twitter(hash)
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