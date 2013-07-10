real_twitter_multiple_users
===========================

Forked repository from SF Dev Bootcamp that uses OAuth validation.

0.1 Load environment variables like this
export $TWITTER_KEY=<key>
export $TWITTER_SECRET=<key>

1. Working on adding users IOT tweet from the app.

2. Deploy to Heroku:

On my laptop, deploy the app to Heroku by adding a Heroku remote.
Run heroku config:add to set up the Twitter key and secret. Then push to Heroku.
Add your app keys like this:

$ heroku config:add TWITTER_KEY=<your_twitter_consumer_key> TWITTER_SECRET=<your_twitter_consumer_secret>

Your keys should never be human-readable in your app. It's all open source code and anyone
can look at it. Or curl it.
