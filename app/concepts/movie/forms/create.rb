# frozen_string_literal: true

module Movie
  module Forms
    Create = Dry::Validation.Form do
      required(:name).filled(:str?)
      optional(:description).filled(:str?)
      optional(:categories).each(included_in?: ENVied.MOVIE_CATEGORIES)
      # TODO: Add custom validation for uuid
      required(:user_id).filled(:str?)
    end
  end
end
