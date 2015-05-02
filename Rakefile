require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = Dir.glob('test/**/*_test.rb')
end

namespace :assets do
  desc "Precompile the assets"
  task :precompile do
    require './yogurt'
    Yogurt.compile_assets
  end
end

namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    require "./models"

    Sequel.extension :migration

    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(DB, "db/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(DB, "db/migrations")
    end
  end

  desc "Populate the database with seeds"
  task :seed do
    require './models.rb'
    load './db/seeds.rb'
  end
end
