class Twitter
  include HTTParty
  base_uri 'twitter.com'
  format :json
  
  def self.user_timeline(screen_name, options = {})
    page    = 1
    tweets  = []
    url     = "/statuses/user_timeline/#{screen_name}.json"
    begin
      while !(batch = get(url, options.merge(:query => {:page => page, :count => 200}))).empty?
        tweets += batch
        page += 1
      end
    rescue Exception => exception
      raise "#{exception}: #{batch.inspect}"
    end
    tweets
  end
end