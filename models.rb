require 'sequel'
require 'logger'
require './lib/env'

DB = Sequel.connect(ENV['DATABASE_URL']).tap do |config|
  config.loggers << Logger.new($stdout)
end

# See: http://permalink.gmane.org/gmane.comp.lang.ruby.sequel/2118
Sequel::Model.raise_on_save_failure = false
Sequel::Model.plugin :timestamps

Dir['./models/*.rb'].each {|f| require f}

require './seeds.rb'
