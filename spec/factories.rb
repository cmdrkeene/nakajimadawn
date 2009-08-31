Factory.define :tweet do |tweet|
  tweet.sequence(:from_user) {|n| "user_#{n}"}
  tweet.text "This is an example tweet"
  tweet.tweeted_at { Time.now }
  tweet.sequence(:status_id) {|n| n}
  tweet.source "<a href=\"http://www.atebits.com/\" rel=\"nofollow\">Tweetie</a>"
end