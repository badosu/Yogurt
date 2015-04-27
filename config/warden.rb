require 'warden'

Warden::Manager.serialize_into_session{|user| user.id }
Warden::Manager.serialize_from_session{|id| User[id] }

Warden::Strategies.add(:password) do
  def valid?
    params["email"] || params["password"]
  end

  def authenticate!
    user = User.first(email: params["email"])

    if user && user.authenticate(params["password"])
      success! user
    end
  end
end

Warden::Strategies.add(:remember_me_token) do
  def valid?
    request.cookies['remember_me_token']
  end

  def authenticate!
    if token = request.cookies['remember_me_token']
      if user = User.first(remember_me_token: token)
        success!(user)
      end
    end
  end
end

Warden::Manager.after_authentication do |user, auth, opts|
  if auth.params['remember_me']
    user.remember_me!

    auth.env['rack.cookies']['remember_me_token'] = user.remember_me_token
  end
end

Warden::Manager.before_logout do |user, auth, opts|
  user.update remember_me_token: nil
end
