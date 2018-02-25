# frozen_string_literal: true

RSpec::Matchers.define :match_schema do |schema|
  match do |response|
    schema_path = "spec/support/api/schemas/#{schema}.json"
    JSON::Validator.validate!(schema_path, response, strict: true)
  end
end
