require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tweet do
  it "should create a new instance given valid attributes" do
    Factory(:tweet).should_not be_a_new_record
  end
    
  describe ".new_from_twitter" do
    it "should initialize a valid tweet from hash" do
      json_hash = {
        "truncated"=>false,
        "created_at"=>"Sun Aug 30 05:29:39 +0000 2009",
        "favorited"=>false,
        "text"=>"@bmizerany @binary42 Scam it up!",
        "id"=>3640288039,
        "in_reply_to_user_id"=>2379441,
        "source"=>"<a href=\"http://www.atebits.com/\" rel=\"nofollow\">Tweetie</a>",
        "in_reply_to_screen_name"=>"bmizerany",
        "user"=>{"profile_sidebar_border_color"=>"D0D0D0",
          "profile_sidebar_fill_color"=>"FFFFFF", 
          "name"=>"Pat Nakajima", 
          "profile_background_tile"=>false, 
          "location"=>"New York", 
          "created_at"=>"Wed Jan 17 07:38:48 +0000 2007", 
          "profile_image_url"=>"http://a3.twimg.com/profile_images/349086635/magic_normal.JPG", 
          "profile_link_color"=>"00AAFF", 
          "url"=>"http://patnakajima.com", 
          "favourites_count"=>98, 
          "id"=>652983, 
          "utc_offset"=>-18000, 
          "protected"=>false, 
          "followers_count"=>398, 
          "profile_text_color"=>"191919", 
          "notifications"=>nil, 
          "time_zone"=>"Eastern Time (US & Canada)", 
          "profile_background_color"=>"FFFFFF", 
          "verified"=>false, 
          "description"=>"the continuing adventures of me", 
          "statuses_count"=>2279, 
          "friends_count"=>180, 
          "profile_background_image_url"=>"http://s.twimg.com/a/1251397346/images/themes/theme1/bg.gif", 
          "following"=>nil,
          "screen_name"=>"nakajima"}, 
        "in_reply_to_status_id"=>3640097946
      }
      tweet = Tweet.new_from_twitter(json_hash)
      tweet.from_user.should == "nakajima"
      tweet.text.should == "@bmizerany @binary42 Scam it up!"
      tweet.tweeted_at.to_s.should == "2009-08-30 01:29:39 -0400"
      tweet.status_id.should == 3640288039
      tweet.source.should == "<a href=\"http://www.atebits.com/\" rel=\"nofollow\">Tweetie</a>"
      tweet.in_reply_to_status_id.should == 3640097946
      tweet.in_reply_to_user_id.should == 2379441
      tweet.in_reply_to_screen_name.should == "bmizerany"
      tweet.should be_valid
    end
  end
  
  describe ".dawn" do
    before do
      @tweet_12am   = Factory(:tweet, :tweeted_at => Time.now.at_midnight)
      @tweet_3am    = Factory(:tweet,:tweeted_at => Time.now.at_midnight + 3.hours)
      @tweet_6am    = Factory(:tweet,:tweeted_at => Time.now.at_midnight + 6.hours)
      @tweet_630am  = Factory(:tweet,:tweeted_at => Time.now.at_midnight + 6.hours + 30.minutes)
      @tweet_5pm    = Factory(:tweet,:tweeted_at => Time.now.at_midnight + 17.hours)
    end
     
    it "should only return tweets between midnight and six, EST" do
      dawn = Tweet.dawn
      dawn.should include(@tweet_12am)
      dawn.should include(@tweet_3am)
      dawn.should_not include(@tweet_6am)
      dawn.should_not include(@tweet_630am)
      dawn.should_not include(@tweet_5pm)
    end
  end
end
