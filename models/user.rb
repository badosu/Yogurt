require 'securerandom'

class User < Sequel::Model
  plugin :secure_password

  def validate
    super
    errors.add(:email, 'must be present') if !email || email.empty?
  end

  def remember_me!
    token = SecureRandom.urlsafe_base64

    until User.where(remember_me_token: token).empty? do
      token = SecureRandom.urlsafe_base64
    end

    update remember_me_token: token
  end
end
