namespace :assets do
  desc "Precompile the assets"
  task :precompile do
    require './yorgut'
    Yorgut.compile_assets
  end
end

namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    require "sequel"
    Sequel.extension :migration
    db = Sequel.connect(ENV.fetch("DATABASE_URL"))
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, "db/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(db, "db/migrations")
    end
  end

  desc "Populate the database with seeds"
  task :seed do
    require './models.rb'
    load './db/seeds.rb'
  end
end
