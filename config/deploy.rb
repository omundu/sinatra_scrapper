# config valid only for current version of Capistrano
lock '3.4.0'

server '104.236.206.30', port: 5753, roles: [:web, :app], primary: true

set :application, 'omundu930'
set :repo_url,    'git@github.com:omundu/sinatra_scrapper.git'
set :user,        'deployer'

set :deploy_to,   '/var/www/omundu930.com'
set :stage,       :production
set :pty,         true
set :use_sudo,    false
set :stage,       :production
set :deploy_via,  :remote_cache
set :ssh_options, { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :linked_dirs, %w{tmp/pids}

set :unicorn_config_path, "config/unicorn.rb"
set :unicorn_conf,        "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid,         "#{deploy_to}/shared/pids/unicorn.pid"

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end