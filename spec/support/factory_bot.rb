# frozen_string_literal: true

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions

    FactoryBot.define do
      initialize_with { new(attributes) }

      to_create do |instance|
        repository = Object.const_get("#{instance.class}Repository").new
        repository.create(instance)
      end
    end
  end
end
