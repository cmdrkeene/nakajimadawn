require File.dirname(__FILE__) + '/../spec_helper'

describe HomepageController do
  integrate_views

  describe "#index" do
    before do
      11.times { Factory(:nakajima_dawn_tweet) }
    end

    it "should show 10 tweets per page" do
      get :index
      assigns[:tweets].size.should == 10
    end

    it "should paginate tweets" do
      get :index, :page => 2
      assigns[:tweets].size.should == 1
    end

    it "should not show hidden tweets" do
      hidden_tweet = Factory(:nakajima_dawn_tweet, :hidden => true)
      get :index, :page => 2
      assigns[:tweets].should_not include(hidden_tweet)
    end

    it "should have an RSS feed"
    it "should have an iPhone view"
  end
end
