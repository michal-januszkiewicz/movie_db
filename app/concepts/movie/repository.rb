# frozen_string_literal: true

module Movie
  class Repository < ROM::Repository[:movies]
    commands :create, update: :by_pk, delete: :by_pk

    def all(search: nil, category_filter: nil, rating_filter: nil)
      movies
        .search_by_name(search)
        .filter_by_category(category_filter)
        .filter_by_rating(rating_filter)
        .to_a
    end

    def one_by_id(id)
      movies
        .by_id(id)
        .one
    end
  end
end
