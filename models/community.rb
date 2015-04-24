class Community < Sequel::Model
  def validate
    super
    errors.add(:name, 'must be present') if !name || name.empty?
  end
end
