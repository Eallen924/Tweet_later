class TweetWorker
  include Sidekiq::Worker

  def perform(tweet_id)
    tweet = Tweet.find(tweet_id)
    user  = tweet.user
    twitter_client = Twitter::Client.new(
        :oauth_token => user.oauth_token,
        :oauth_token_secret => user.oauth_secret)
    # set up Twitter OAuth client here
    twitter_client.update(tweet.status)
    # actually make API call
    # Note: this does not have access to controller/view helpers
    # You'll have to re-initialize everything inside here
  end
end
