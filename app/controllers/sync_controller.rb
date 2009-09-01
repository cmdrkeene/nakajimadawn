class SyncController < ApplicationController
  def show
    # begin
      response = Nakajima.sync!
      raise response["error"] if response["error"]
      if response.size > 0
        render :text => "#{response.size} new tweet#{'s' if response.size > 1} from @nakajima", :status => 201
      else
        render :text => nil, :response => 304
      end
    # rescue Exception => exception
    #   render :text => "Error: #{exception}"
    # end
  end
end