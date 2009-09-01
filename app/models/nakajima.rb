class Nakajima
  SCREEN_NAME = 'nakajima'
  
  def self.dawn(options = {})
    Twitter.user_timeline(SCREEN_NAME, options).select do |tweet|
      is_dawn?(Time.parse(tweet["created_at"]))
    end
  end
  
  def self.sync!
    saved = []
    since_id = Tweet.newest && Tweet.newest.status_id
    logger.info("Finding since status_id #{since_id}") if since_id
    new_tweets = dawn({:since_id => since_id})
    logger.info("Found #{new_tweets.size} JSON tweets")
    new_tweets.each do |tweet|
      t = Tweet.new_from_hash(tweet)
      if t.save
        saved << t
      end
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