pid 'tmp/pids/unicorn.pid'

after_fork do |master, worker|
  old_pid_path = "#{master.pid}.oldbin"

  if File.exists? old_pid_path
    old_master_pid = File.read(old_pid_path).to_i
    worker_number = worker.nr + 1 # first is 0

    if worker_number < master.worker_processes
      signal = :WINCH # gracefully shut down workers
    else
      signal = :QUIT
    end

    Process.kill signal, old_master_pid
  end
end
