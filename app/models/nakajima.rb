class Nakajima
  SCREEN_NAME = 'nakajima'
  
  def self.dawn(options = {})
    Twitter.user_timeline(SCREEN_NAME, options).select do |tweet|
      is_dawn?(Time.parse(tweet["created_at"]))
    end
  end
  
  def self.sync!
    saved = []
    options = {}
    if Tweet.newest
      options[:since_id] = Tweet.newest.status_id
    end
    dawn(options).each do |tweet|
      t = Tweet.new_from_hash(tweet)
      saved << t if t.save
    end
    saved
  end
  
  private

  def self.logger
    ActiveRecord::Base.logger
  end
  
  def self.is_dawn?(time)
    (time >= time.at_midnight) && (time <= (time.at_midnight + 6.hours))
  end
end