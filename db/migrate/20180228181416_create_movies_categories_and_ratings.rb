ROM::SQL.migration do
  change do
    create_table :movies do
      primary_key :id

      column :name, String, null: false
      column :description, String
      column :categories, 'Text[]', null: false
      column :rating, Integer

      column :created_at, DateTime, null: false, default: Sequel::CURRENT_TIMESTAMP
      column :updated_at, DateTime, null: false, default: Sequel::CURRENT_TIMESTAMP

      foreign_key :user_id, :users, type: :uuid, null: false, on_delete: :set_null

      index :name, unique: true
    end

    create_table :movie_rating do
      foreign_key :movie_id, :movies, null: false, on_delete: :cascade
      foreign_key :user_id, :users, type: :uuid, null: false, on_delete: :set_null

      column :value, Integer, null: false

      column :created_at, DateTime, null: false, default: Sequel::CURRENT_TIMESTAMP
      column :updated_at, DateTime, null: false, default: Sequel::CURRENT_TIMESTAMP

      index [:movie_id, :user_id], unique: true
    end
  end
end
