require 'roda'

class Yogurt < Roda
  use Rack::Session::Cookie, secret: ENV['SECRET']
  use Rack::MethodOverride

  plugin :all_verbs
  plugin :symbol_views
  plugin :view_options
  plugin :render, ext: 'html.erb', layout: '/layout'
  plugin :static, ["/images", "/fonts"]
  plugin :assets,  js: { yogurt: ["jquery-2.1.3.js", "bootstrap.js"] }
  plugin :assets, css: {  home: ["bootstrap.css", "jumbotron.css"],
                         yogurt: ["bootstrap.css", "yogurt.css"] }
  plugin(:not_found) { view '/http_404' }

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

    r.on 'communities' do
      set_view_subdir 'communities'

      r.is do
        @communities = Community.order(Sequel.desc(:created_at)).all

        view :index
      end

      r.is 'new' do
        @community = Community.new

        r.get do
          view :new
        end

        r.post do
          @community.set_fields(r.params, %w[name description private])

          if @community.save
            r.redirect '/communities'
          else
            view :new
          end
        end
      end

      r.on ':id' do |id|
        @community = Community.with_pk!(id.to_i)

        r.get('edit') do
          view :edit
        end

        r.put do
          @community.set_fields(r.params, %w[name description private])

          if @community.save
            r.redirect '/communities'
          else
            view :edit
          end
        end

        r.delete do
          @community.delete

          r.redirect '/communities'
        end
      end
    end

    r.assets
  end
end
