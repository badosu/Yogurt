require './lib/env'
require './config/unreloader'

Unreloader.require './models.rb'
Unreloader.require './yogurt.rb'

run(env.development? ? Unreloader : Yogurt.freeze.app)
