# frozen_string_literal: true

include SpecHelpers::JwtToken

FactoryBot.define do
  factory :token do
    transient do
      user { build(:user) }
    end

    revoked false
    value { generate_token(email: user[:email]) }
    user_id { user[:id] }

    initialize_with { ROM.env.relations[:tokens].command(:create).call(attributes) }
  end
end
