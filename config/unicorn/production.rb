app_root = File.dirname(File.dirname(File.dirname(__FILE__)))

pid         "#{app_root}/tmp/pids/unicorn.pid"
stderr_path "#{app_root}/log/unicorn.stderr.log"
