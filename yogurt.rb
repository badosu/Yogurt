require 'roda'

class Yogurt < Roda
  use Rack::Session::Cookie, secret: ENV['SECRET']
  use Rack::MethodOverride

  plugin :all_verbs
  plugin :symbol_views
  plugin :view_options
  plugin :render, ext: 'html.erb', layout: '/layout'
  plugin :static, %w[/images /fonts]
  plugin :multi_route
  plugin :assets, group_subdirs: false,
         css: { home:   %w[lib/bootstrap.css jumbotron.css],
                yogurt: %w[lib/bootstrap.css yogurt.css] },
         js:  { yogurt: %w[lib/jquery-2.1.3.js lib/bootstrap.js] }
  plugin(:not_found) { view '/http_404' }

  if env.development?
    require 'pry'
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

Dir.glob('routes/*.rb') { |f| require_relative f }
