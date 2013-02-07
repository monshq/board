set :rvm_ruby_string, '1.9.3-p327'
set :rvm_install_ruby_params, '--patch falcon'

before 'deploy:setup', 'rvm:install_rvm'
before 'deploy:setup', 'rvm:install_ruby'

require 'rvm/capistrano'

set :bundle_flags, '--deployment'

require 'bundler/capistrano'

set :application, 'board'
set :repository,  'https://github.com/monshq/board.git'
set :branch,      'master'

if ENV['TRAVIS']
  host = ENV['EXTERNAL_IP']
  set :password, ENV['DEPLOYER_PASSWORD']
else
  host = '192.168.20.9'
end

server host, :web, :app, :db, primary: true
set :user, 'deployer'
set :deploy_to, '/home/deployer'
set :shared_children, %w(public/system public/uploads log tmp/pids)
set :use_sudo, false
default_run_options[:pty] = true

set :deploy_via, :remote_cache

after 'deploy:setup' do
  run "mkdir -p #{shared_path}/uploads"
end

before 'deploy:assets:precompile' do
  db_config = "#{release_path}/config/database.yml"
  run "mv -f #{db_config}.production #{db_config}"
end

after 'deploy:update', 'deploy:migrate'

require 'capistrano-unicorn'

after 'deploy:restart' do
  run <<-CMD.compact
    cd -- #{latest_release.shellescape} &&
    bundle exec mailcatcher --http-ip 192.168.20.9
  CMD
end
