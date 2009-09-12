class HomepageController < ApplicationController
  def index
    @newest_tweet = Tweet.newest
    fresh_when(:etag => @newest_tweet, :last_modified => @newest_tweet.created_at, :public => true)
    @tweets = Nakajima.dawn.paginate :order    => 'tweeted_at DESC',
                                     :page     => params[:page],
                                     :per_page => 10
  end
end