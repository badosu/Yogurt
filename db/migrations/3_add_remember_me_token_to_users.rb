Sequel.migration do
  change do
    alter_table(:users) do
      add_column :remember_me_token, String

      add_index :remember_me_token
    end
  end
end
