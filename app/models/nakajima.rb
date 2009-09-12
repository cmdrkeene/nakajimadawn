class Nakajima
  USERNAME = 'nakajima'
  
  def self.save_new_tweets
    new_tweets.each do |hash|
      Tweet.new_from_twitter(hash).save!
    end
  end
  
  def self.dawn
    Tweet.from_user(USERNAME).dawn
  end
  
  private
  
  def self.new_tweets
    options = {}
    options[:since_id] = since_id if since_id
    Twitter.user_timeline(USERNAME, options)
  end
  
  def self.since_id
    last = Tweet.from_user(USERNAME).last
    last && last.status_id
  end
end