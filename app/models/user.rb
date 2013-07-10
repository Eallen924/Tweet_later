class User < ActiveRecord::Base
  validates :twitter_id, :uniqueness => true

  has_many :tweets
  def tweet(status)
    tweet = tweets.create!(:status => status)
    TweetWorker.perform_async(tweet.id)
  end

  def tweet_later(seconds, status)
    tweet = tweets.create!(:status => status)
    TweetWorker.perform_in(seconds.seconds, tweet.id)
  end 
end
