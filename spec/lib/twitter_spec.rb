require File.dirname(__FILE__) + '/../spec_helper'

describe Twitter do
  describe ".user_timeline" do
    it "should grab all tweets for a screen name" do
      timeline = Twitter.user_timeline('bancroftdoorman')
      timeline.size.should == 12
    end
    
    describe "with multiple pages" do
      it "should grab all pages" do
        timeline = Twitter.user_timeline('nakajima')
        timeline.size.should == 39
      end
    end
  end
end
