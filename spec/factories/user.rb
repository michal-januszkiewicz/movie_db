# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Internet.user_name }
    email { Faker::Internet.unique.email }

    initialize_with { ROM.env.relations[:users].command(:create).call(attributes) }
  end
end
