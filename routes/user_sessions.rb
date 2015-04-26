class Yogurt
  route 'user_sessions' do |r|
    r.is do
      r.post do
        env['warden'].authenticate!

        r.redirect session[:return_to] || '/communities'
      end

      r.delete do
        env['warden'].logout

        r.redirect '/user_sessions/new'
      end
    end

    r.get 'new' do
      render '/user_sessions/new'
    end

    r.is 'unauthenticated' do
      session[:return_to] = env['warden.options'][:attempted_path]
      response.status = 403

      render '/user_sessions/new'
    end
  end
end
