require 'roda'
require './config/warden'

class Yogurt < Roda
  use Rack::Session::Cookie, secret: ENV['SECRET']
  use Rack::MethodOverride

  plugin :all_verbs
  plugin :symbol_views
  plugin :view_options
  plugin :flash
  plugin :render, ext: 'html.erb', layout: '/layout'
  plugin :static, %w[/images /fonts]
  plugin :multi_route
  plugin :assets, group_subdirs: false,
         css: { home:   %w[lib/bootstrap.css jumbotron.css],
                yogurt: %w[lib/bootstrap.css yogurt.css signin.css] },
         js:  { yogurt: %w[lib/jquery-2.1.3.js lib/bootstrap.js] }
  plugin(:not_found) { view '/http_404' }

  use Warden::Manager do |manager|
    manager.scope_defaults :default,
      strategies: [:password],
      action: 'user_sessions/unauthenticated'
    manager.failure_app = self
  end

  if env.development?
    require 'better_errors'
    require 'pry'

    use BetterErrors::Middleware
    BetterErrors.application_root = __dir__
  else
    compile_assets

    plugin :error_handler do |e|
      case e
      when Sequel::NoMatchingRow
        response.status = 404
        view '/http_404'
      else
        view '/http_500'
      end
    end
  end

  route do |r|
    r.root { render(:index) }

    r.multi_route

    r.assets
  end
end

Unreloader.require('routes'){}
Unreloader.record_split_class(__FILE__, 'routes')
Unreloader.record_split_class(__FILE__, 'config/warden')
