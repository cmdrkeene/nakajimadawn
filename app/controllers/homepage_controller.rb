class HomepageController < ApplicationController
  def index
    @tweets = Tweet.paginate :order     => 'created_at DESC',
                             :page      => params[:page],
                             :per_page  => 10
  end
end