# frozen_string_literal: true

require "./spec/dummies/use_case_dummy"

describe Movie::Controllers::MoviesController, type: :controller do
  describe "#index" do
    subject(:get_index) { get :index, params: params }

    let(:movies) { Array.new(2) { build(:movie) } }
    let(:params) do
      {
        search: "Interstellar",
        category_filter: "Science Fiction",
        rating_filter: 5,
      }
    end

    before do
      controller.instance_variable_set("@movies_index", UseCaseDummy)
      allow(UseCaseDummy).to receive(:call).and_return(movies)
      get_index
    end

    it { expect(response.status).to eq(200) }
    it { expect(json_body.pluck("name")).to match_array(movies.pluck(:name)) }
    it { expect(json_body.first).to match_schema("movie") }
  end
end
