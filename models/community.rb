DB.drop_table? :communities
DB.create_table(:communities) do
  primary_key :id

  column :name,        String,    null: false
  column :description, String
  column :private,     TrueClass, default: false
  column :created_at,  DateTime
  column :updated_at,  DateTime
end

class Community < Sequel::Model
  def validate
    super
    errors.add(:name, 'must be present') if !name || name.empty?
  end
end
