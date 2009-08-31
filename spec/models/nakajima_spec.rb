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
  
  describe ".update!" do
    it "should update all tweets from dawn" do
      lambda {
        Nakajima.update!
      }.should change { Tweet.count }.by(15)
      lambda {
        Nakajima.update!
      }.should_not change { Tweet.count }
    end
    
    describe "with a tweet already created" do
      it "should update from a since_id" do
        Nakajima.update!
        lambda {
          Nakajima.update!
        }.should change { Tweet.count }.by(1)
      end
    end
  end
end