require File.dirname(__FILE__) + '/../spec_helper'

describe Nakajima do
  describe ".save_new_tweets" do
    it "should save all tweets" do
      lambda {
        Nakajima.save_new_tweets
      }.should change { Tweet.count }.by(39)
    end
  end
end
