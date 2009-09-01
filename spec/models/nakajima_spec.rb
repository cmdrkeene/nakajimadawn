require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Nakajima do
  describe ".dawn" do
    it "should only return tweets between midnight and six am" do
      dawn = Nakajima.dawn
      dawn.size.should == 15
      dawn.each do |tweet|
        time = Time.parse(tweet["created_at"])
        time.should >= time.at_midnight
        time.should <= time.at_midnight + 6.hours
      end
    end
  end
  
  describe ".sync!" do
    it "should sync all tweets from dawn" do
      lambda {
        Nakajima.sync!
      }.should change { Tweet.count }.by(15)
      lambda {
        Nakajima.sync!
      }.should change { Tweet.count }.by(1)
      lambda {
        Nakajima.sync!
      }.should_not change { Tweet.count }
    end    
  end
end