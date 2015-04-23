require './lib/env'
require 'rack/unreloader'

Unreloader = Rack::Unreloader.new(reload: env.development?,
                                  subclasses: %w'Roda Sequel::Model'){ Yogurt }

Unreloader.require './models.rb'
Unreloader.require './yogurt.rb'

run(env.development? ? Unreloader : Yogurt.freeze.app)
