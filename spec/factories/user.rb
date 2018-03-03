# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id { SecureRandom.uuid }
    name { Faker::Internet.user_name }
    email { Faker::Internet.unique.email }

    initialize_with { attributes }

    trait :persisted do
      initialize_with { ROM.env.relations[:users].command(:create).call(attributes) }
    end
  end
end
