set :rvm_ruby_string, '1.9.3-p327'
set :rvm_install_ruby_params, '--patch falcon'

before 'deploy:setup', 'rvm:install_rvm'
before 'deploy:setup', 'rvm:install_ruby'

require 'rvm/capistrano'

set :bundle_flags, '--deployment'

require 'bundler/capistrano'

set :application, 'board'
set :repository,  'https://github.com/vassilevsky/board.git'
set :branch,      'feature-17-deployment'

server '192.168.20.9', :web, :app, :db, primary: true
set :user, 'deployer'
set :deploy_to, '/home/deployer'
set :use_sudo, false
default_run_options[:pty] = true

set :deploy_via, :remote_cache

before 'deploy:assets:precompile' do
  put """production:
  adapter: postgresql
  username: board1
  password: board1
  database: board1_production
  """, "#{release_path}/config/database.yml"
end

after 'deploy:update', 'deploy:migrate'

require 'capistrano-unicorn'

after 'deploy:restart' do
  run 'mailcatcher'
end
