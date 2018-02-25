ROM::SQL.migration do
  change do
    create_table :tokens do
      primary_key :value, String

      column :revoked, TrueClass, null: false, default: false
      foreign_key :user_id, :users, type: :uuid, null: false, on_delete: :cascade

      column :created_at, DateTime, null: false, default: Sequel::CURRENT_TIMESTAMP
      column :updated_at, DateTime, null: false, default: Sequel::CURRENT_TIMESTAMP
    end
  end
end
