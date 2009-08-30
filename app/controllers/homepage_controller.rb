class HomepageController < ApplicationController
  def index
    @tweets = Tweet.all(:order => 'created_at DESC', :limit => 25)
  end
end