require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tweet do
  before(:each) do
    @valid_attributes = {
      :text => "value for text",
      :from_user => "value for from_user",
      :profile_image_url => "value for profile_image_url",
      :source => "value for source",
      :twitter_id => "value for twitter_id",
      :tweeted_at => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    Tweet.create!(@valid_attributes)
  end
end
