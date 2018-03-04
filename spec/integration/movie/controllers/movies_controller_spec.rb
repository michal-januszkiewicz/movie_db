# frozen_string_literal: true

describe Movie::Controllers::MoviesController, type: :request do
  include SpecHelpers::JwtToken

  describe "#index" do
    subject(:get_index) { get "/api/v1/movies", params: params }

    before { get_index }

    context "when the searched movie doesn't exist" do
      let(:params) do
        {
          search: "Guardians of the",
          category_filter: "Comedy",
          rating_filter: 5,
        }
      end

      it { expect(response.status).to eq(200) }
      it { expect(json_body).to eq([]) }
    end

    # TODO: Add more tests
  end

  describe "#create" do
    subject(:post_create) { post "/api/v1/movies", params: params, headers: headers }

    before { post_create }

    context "when authenticated" do
      # TODO: Extract to a helper.
      let(:user) { build(:user, :persisted) }
      let(:token) { build(:token, :persisted, user: user) }
      let(:headers) { { "Authorization" => "Token #{token[:value]}" } }

      let(:params) { movie.as_json.except(:id, :rating, :user_id) }

      context "when movie doesn't exist" do
        let(:movie) { build(:movie) }

        it { expect(response.status).to eq(201) }
        it { expect(json_body["name"]).to eq(movie[:name]) }
        it { expect(json_body).to match_schema("movie") }
      end

      context "when movie already exists" do
        let(:movie) { build(:movie, :persisted) }

        it { expect(response.status).to eq(422) }
        it { expect(json_body["errors"]).to include("duplicate key value", "movies_name_index") }
      end
    end

    context "when unauthenticated" do
      let(:headers) { {} }
      let(:params) { {} }

      it { expect(response.status).to eq(401) }
    end
  end
end
