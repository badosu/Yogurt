Sequel.migration do
  change do
    create_table(:communities) do
      primary_key :id

      column :name,        String,    null: false
      column :description, String
      column :private,     TrueClass, default: false
      column :created_at,  DateTime
      column :updated_at,  DateTime
    end
  end
end
