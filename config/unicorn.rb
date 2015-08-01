deploy_path = "/var/www/omundu930.com"
rack_root = "#{deploy_path}/current"
pid_file = "#{deploy_path}/shared/pids/unicorn.pid"
socket_file= "#{deploy_path}/shared/unicorn.sock"
log_file = "#{rack_root}/log/unicorn.log"
err_log = "#{rack_root}/log/unicorn_error.log"
old_pid = pid_file + '.oldbin'

timeout 30
worker_processes 2
listen socket_file, :backlog => 1024

pid pid_file
stderr_path err_log
stdout_path log_file

# use correct Gemfile on restarts
before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{deploy_path}/current/Gemfile"
end

# preload
preload_app true

before_fork do |server, worker|
  # Before forking, kill the master process that belongs to the .oldbin PID.
  # This enables 0 downtime deploys.
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end