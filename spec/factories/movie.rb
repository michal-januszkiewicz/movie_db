# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    sequence :id
    # Somehow Faker doesn't have movie names but there's a good chance a movie was based on a book.
    name { Faker::Book.unique.title }
    description { Faker::Lorem.paragraph }
    categories { Sequel.pg_array(%w(Drama Comedy)) }
    rating { Faker::Number.between(1, 5) }
    user_id { SecureRandom.uuid }

    initialize_with { attributes }

    trait :persisted do
      user_id { build(:user, :persisted)[:id] }
      initialize_with { ROM.env.relations[:movies].command(:create).call(attributes) }
    end
  end
end
