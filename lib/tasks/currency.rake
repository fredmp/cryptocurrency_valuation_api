require 'net/http'
require 'json'
require 'uri'

namespace :currency do
  desc 'This task fetches currencies'
  task :batch_update, [:offset] => :environment do |t, args|
    puts DataUpdater.new(ENV['SOURCE_URL'], args[:offset] || 0).execute
  end

  desc 'Clean up old currency update entries'
  task :clean_up => :environment do
    CurrencyUpdate.old_entries.delete_all
  end
end
