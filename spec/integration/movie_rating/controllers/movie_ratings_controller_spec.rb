# frozen_string_literal: true

describe MovieRating::Controllers::MovieRatingsController, type: :request do
  include SpecHelpers::JwtToken

  describe "#create" do
    subject(:post_create) { post "/api/v1/movie_ratings", params: params, headers: headers }

    before { post_create }

    context "when authenticated" do
      # TODO: Extract to a helper.
      let(:user) { build(:user, :persisted) }
      let(:token) { build(:token, :persisted, user: user) }
      let(:headers) { { "Authorization" => "Token #{token[:value]}" } }

      let(:params) { movie_rating.as_json.except(:user_id, :id) }
      let(:movie_rating) { build(:movie_rating, movie_id: movie[:id]) }

      context "when movie doesn't exist" do
        let(:movie) { build(:movie) }

        it { expect(response.status).to eq(404) }
      end

      context "when movie exists" do
        let(:movie) { build(:movie, :persisted, rating: 0) }
        let(:movie_repository) { Movie::Repository.new(ROM.env) }

        it { expect(response.status).to eq(201) }
        it { expect(json_body["value"]).to eq(movie_rating[:value]) }
        it { expect(json_body).to match_schema("movie_rating") }
        it { expect(movie_repository.one_by_id(movie[:id])[:rating]).to eq(movie_rating[:value]) }
      end

      context "when rating already exists" do
        let(:movie) { build(:movie, :persisted) }
        let(:movie_rating) do
          build(:movie_rating, :persisted, user_id: user[:id], movie_id: movie[:id])
        end

        it { expect(response.status).to eq(422) }
      end
    end

    context "when unauthenticated" do
      let(:headers) { {} }
      let(:params) { {} }

      it { expect(response.status).to eq(401) }
    end
  end
end
