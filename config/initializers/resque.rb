
Resque.logger.formatter = Resque::VeryVerboseFormatter.new
Resque.logger = MonoLogger.new(File.open("#{Rails.root}/log/resque.log", "w+"))	