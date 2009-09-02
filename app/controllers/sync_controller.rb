class SyncController < ApplicationController
  def show
    begin
      new_tweets = Nakajima.save_all_tweets
      if new_tweets.size > 0
        size = new_tweets.size
        render :text => "#{size} new tweet#{'s' if size > 1} from @nakajima", :status => 201
      else
        render :text => "Nothing added"
      end
    rescue Exception => exception
      render :text => "Error: #{exception}"
    end
  end
end