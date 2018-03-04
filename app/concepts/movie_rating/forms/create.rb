# frozen_string_literal: true

module MovieRating
  module Forms
    Create = Dry::Validation.Form do
      required(:user_id).filled(:str?)
      required(:movie_id).filled(:int?)
      required(:value).filled { int? & gteq?(1) & lteq?(5) }
    end
  end
end
