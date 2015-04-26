Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id

      column :email,           String,    null: false
      column :password_digest, String

      column :created_at,      DateTime,  null: false
      column :updated_at,      DateTime
    end
  end
end
