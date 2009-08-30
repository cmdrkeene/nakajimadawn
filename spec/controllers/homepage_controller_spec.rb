require File.dirname(__FILE__) + '/../spec_helper'

describe HomepageController do
  integrate_views
  
  describe "#index" do
    before do
      11.times { Factory(:tweet) }
    end
    
    it "should show 10 tweets per page" do
      get :index
      assigns[:tweets].size.should == 10
    end
    
    it "should paginate tweets" do
      get :index, :page => 2
      assigns[:tweets].size.should == 1
    end
    
    it "should have an RSS feed"
  end
end
