class Nakajima
  SCREEN_NAME = 'nakajima'
  
  def self.dawn(options = {})
    Twitter.user_timeline(SCREEN_NAME, options).select do |tweet|
      is_dawn?(Time.parse(tweet["created_at"]))
    end
  end
  
  private
  
  def self.is_dawn?(time)
    (time >= time.at_midnight) && (time <= (time.at_midnight + 6.hours))
  end
end