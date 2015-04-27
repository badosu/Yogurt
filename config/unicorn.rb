if ENV["RACK_ENV"] == "production"
  worker_processes ENV["CONCURRENCY"].to_i || 3
else
  worker_processes 1
end
