# frozen_string_literal: true

FactoryBot.define do
  factory :movie_rating do
    sequence :id
    sequence :movie_id
    sequence :user_id
    value { Faker::Number.between(1, 5) }

    initialize_with { attributes }

    trait :persisted do
      movie_id { build(:movie, :persisted)[:id] }
      user_id { build(:user, :persisted)[:id] }

      initialize_with { ROM.env.relations[:movie_ratings].command(:create).call(attributes) }
    end
  end
end
