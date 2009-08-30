class Twitter
  include HTTParty
  base_uri 'twitter.com'
  format :json
  
  def self.user_timeline(screen_name, options = {})
    page    = 1
    tweets  = []
    url     = "/statuses/user_timeline/#{screen_name}.json"
    while !(batch = get(url, options.merge(:query => {:page => page, :count => 200}))).empty?
      tweets += batch
      page += 1
    end
    tweets
  end
end