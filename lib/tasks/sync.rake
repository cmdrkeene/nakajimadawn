namespace :nakajima do
  desc "Sync @nakajima's tweets"
  task :sync => :environment do
    application       = 'Nakajima Dawn'
    icon_application  = 'Tweetie'
    synced = []
    elapsed = Benchmark.realtime do
      synced = Nakajima.sync!
    end
    message = "#{synced.size} new tweet#{'s' if synced.size > 1} from @nakajima (took #{elapsed}s)"
    
    growl_command = "growlnotify -a '#{icon_application}' -n '#{application}' -t '#{application}' -m '#{message}'"
    unless synced.empty?  
      system(growl_command)
    else
      system(growl_command + " -p 'Emergency'")
    end
  end
end