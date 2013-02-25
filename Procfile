web: bundle exec rails server
mailcatcher: mailcatcher -f
resque: bundle exec rake resque:work QUEUE='*'
scheduler: bundle exec rake resque:scheduler