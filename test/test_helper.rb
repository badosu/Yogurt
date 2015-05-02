require "minitest/autorun"
require "rack/test"
require "pry"

require './models.rb'
require './yogurt.rb'

class MiniTest::Test
  alias_method :_original_run, :run

  def run(*args, &block)
    result = nil
    Sequel::Model.db.transaction(:rollback => :always, :auto_savepoint=>true) do
      result = _original_run(*args, &block)
    end
    result
  end
end
