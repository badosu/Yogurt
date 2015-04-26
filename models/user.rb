class User < Sequel::Model
  plugin :secure_password

  def validate
    super
    errors.add(:email, 'must be present') if !email || email.empty?
  end
end
