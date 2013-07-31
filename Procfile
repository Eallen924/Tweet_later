web: bundle exec rails server thin -p $PORT 
web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
worker: bundle exec sidekiq -r./config/environment.rb