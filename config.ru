require './lib/env'
require './lib/unreloader'

Unreloader.require './models.rb'
Unreloader.require './yogurt.rb'

run(env.development? ? Unreloader : Yogurt.freeze.app)
