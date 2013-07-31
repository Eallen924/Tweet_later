require 'twitter'

get '/' do
  if current_user
    @recent_tweets = twitter_client(current_user.oauth_token, current_user.oauth_secret).user_timeline
  else
    @error = "Did not find any tweets for this user"
  end

  if request.xhr?
    tweet = @recent_tweets.first
    content_type :json
    {pic: tweet.user.profile_image_url, 
     username: tweet.user.username,
     text: tweet.text}.to_json
  else
    erb :index
  end
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)
  # at this point in the code is where you'll need to create your user account and store the access token
  user = User.find_or_create_by_twitter_id(@access_token.params[:user_id])
  user.update_attributes!(username: @access_token.params[:screen_name],oauth_token: @access_token.token, oauth_secret: @access_token.secret)
  session[:user] = user.id
  redirect '/'
end

post '/tweet' do
  p params
  user = User.find(session[:user])
  # job_id = user.tweet(params[:tweet])
  job_id = user.tweet_later(params[:seconds].to_i, params[:tweet])
  # client = twitter_client(user.oauth_token, user.oauth_secret)
  # client.update(params[:tweet])
  
  # 200
  if request.xhr?
    content_type :json
    {job_id: job_id}.to_json
  else
    redirect '/'
  end
end

get '/status/:job_id' do
  # return the status of a job to an AJAX call
  complete = job_is_complete(params[:job_id])
  
  content_type :json
  {done: complete}.to_json
end
