ROM::SQL.migration do
  up do
    run 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp"'
    Sequel::Model.plugin :timestamps

    create_table :users do
      primary_key :id, :uuid, default: Sequel.function(:uuid_generate_v4)

      column :name, String, null: false
      column :email, String, null: false

      column :created_at, DateTime, null: false, default: Sequel::CURRENT_TIMESTAMP
      column :updated_at, DateTime, null: false, default: Sequel::CURRENT_TIMESTAMP

      index :email, unique: true
    end
  end

  down do
    run 'DROP EXTENSION IF EXISTS "uuid-ossp" CASCADE'
    drop_table :users
  end
end
