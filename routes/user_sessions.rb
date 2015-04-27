class Yogurt
  route 'user_sessions' do |r|
    r.is do
      r.post do
        env['warden'].authenticate!

        flash[:success] = "You are logged in"

        r.redirect session[:return_to] || '/communities'
      end

      r.delete do
        env['warden'].logout if env['warden'].authenticated?

        flash[:success] = "You are logged out"

        r.redirect '/user_sessions/new'
      end
    end

    r.get 'new' do
      render '/user_sessions/new'
    end

    r.is 'unauthenticated' do
      session[:return_to] = env['warden.options'][:attempted_path]
      response.status = 403

      flash[:danger] = "Could not authenticate"

      render '/user_sessions/new'
    end
  end
end
