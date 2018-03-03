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
end
