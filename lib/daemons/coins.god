RAILS_ENV  = ENV.fetch('RAILS_ENV', 'development')
RAILS_ROOT = File.expand_path('../../..', __FILE__)

God.watch do |w|
     pid_file = File.join(RAILS_ROOT, "tmp/pids/coins.pid")

     w.dir      = "#{RAILS_ROOT}"
     w.name     = "coins"
     w.interval = 30.seconds
     w.env      = {"RAILS_ENV" => RAILS_ENV}
     w.interval = 30.seconds
     w.start = "coins -c #{RAILS_ROOT}/lib/daemons/coins.rb"
     w.stop = "kill -s QUIT $(cat #{pid_file})"
     w.restart = "kill -s HUP $(cat #{pid_file})"
     w.pid_file = pid_file
     w.keepalive

     #more logic for transitioning states

end