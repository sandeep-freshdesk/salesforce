class Sleeper
  @queue = :sleep
  #bundle exec rake environment resque:work QUEUE=sleep 
  # by using above command worker will pop this job from queuq and start working on it
  def self.perform(seconds)
  	puts "workder pop this job from queue and started this job"
  	puts "going to sleep for #{seconds} seconds"
    sleep(seconds)
  	puts "sleep for #{seconds} seconds is done"
  end
end