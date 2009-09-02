class HomepageController < ApplicationController
  def index
    # expires_in 1.hour, :public => true
    
    @tweets = Nakajima.dawn.paginate :order    => 'tweeted_at DESC',
                                     :page     => params[:page],
                                     :per_page => 10
  end
end