# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    # Somehow Faker doesn't have movie names but there's a good chance a movie was based on a book.
    name { Faker::Book.unique.title }
    description { Faker::Lorem.paragraph }
    categories { Sequel.pg_array(%w(Drama Comedy)) }
    rating { Faker::Number.between(1, 5) }
    user_id { build(:user)[:id] }

    initialize_with { ROM.env.relations[:movies].command(:create).call(attributes) }
  end
end
