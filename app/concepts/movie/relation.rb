# frozen_string_literal: true

module Movie
  class Relation < ROM::Relation[:sql]
    schema(:movies, infer: true) do
      associations do
        # has_many :movie_ratings
        belongs_to :user
      end
    end

    def by_id(id)
      where(id: id)
    end

    def search_by_name(name)
      return self if name.nil?
      where(Sequel.ilike(:name, "%#{name}%"))
    end

    def filter_by_category(category)
      return self if category.nil?
      where(Sequel.ilike(Sequel.function(:array_to_string, :categories, " "), "%#{category}%"))
    end

    def filter_by_rating(rating)
      return self if rating.nil?
      where(rating: rating)
    end
  end
end
