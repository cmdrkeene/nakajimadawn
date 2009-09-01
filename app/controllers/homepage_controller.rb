class HomepageController < ApplicationController
  def index
    expires_in 1.hour, :public => true
    
    @tweets = Tweet.paginate :order     => 'tweeted_at DESC',
                             :page      => params[:page],
                             :per_page  => 10
  end
end