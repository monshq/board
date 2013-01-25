set :rvm_ruby_string, '1.9.3-p327'
set :rvm_install_ruby_params, '--patch falcon'
require 'rvm/capistrano'

# default is '--deployment --quiet'
# --quiet is bad, hides useful error messages
set :bundle_flags, '--deployment'
require 'bundler/capistrano'

set :application, 'board'
set :repository,  'git@github.com:vassilevsky/board.git'
set :branch,      'master'

server '192.168.20.9', :web, :app, :db, primary: true
set :user, 'vassilevsky'
default_run_options[:pty] = true
set :deploy_to, '/var/www/board1'

set :deploy_via, :remote_cache

before 'deploy:setup', 'rvm:install_rvm'
before 'deploy:setup', 'rvm:install_ruby'

# after 'deploy:update_code' do
# if executed this way ^^^, executes after all other callbacks
# but it needs to be executed before asset compilation
before 'deploy:assets:precompile' do
  put """production:
  adapter: postgresql
  username: board1
  password: board1
  database: board1_production
  """, "#{release_path}/config/database.yml"
end

require 'capistrano-unicorn'
