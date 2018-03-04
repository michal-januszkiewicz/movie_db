# frozen_string_literal: true

describe MovieRating::Repository do
  describe "#all_for_movie" do
    subject(:call_method) { described_class.new(ROM.env).all_for_movie(movie[:id]) }

    let(:movie) { build(:movie, :persisted) }
    let(:movie_ratings) { Array.new(3) { build(:movie_rating, :persisted, movie_id: movie[:id]) } }

    let(:other_movie) { build(:movie, :persisted) }
    let(:other_movie_ratings) do
      Array.new(3) { build(:movie_rating, :persisted, movie_id: other_movie[:id]) }
    end

    before do
      movie
      movie_ratings
      other_movie
      other_movie_ratings
    end

    it { expect(call_method.pluck(:id)).to match_array(movie_ratings.pluck(:id)) }
  end
end
