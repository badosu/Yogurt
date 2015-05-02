require 'sequel'
require 'logger'
require './lib/env'
require './config/unreloader'

DB = Sequel.connect(ENV['DATABASE_URL']).tap do |config|
  config.loggers << Logger.new($stdout) unless env.test?
end

# See: http://permalink.gmane.org/gmane.comp.lang.ruby.sequel/2118
Sequel::Model.raise_on_save_failure = false
Sequel::Model.plugin :timestamps

Unreloader.require('models'){}
Unreloader.record_split_class(__FILE__, 'models')
