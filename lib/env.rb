require './lib/string_inquirer'

def env
  StringInquirer.new ENV['RACK_ENV']
end
