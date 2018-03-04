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

  describe "#create" do
    subject(:post_create) { post :create, params: params }

    let(:movie) { build(:movie) }
    let(:params) { movie.as_json.except(:id, :rating) }
    let(:user) { build(:user) }

    before do
      # TODO: Extract authentication mock to a helper.
      allow_any_instance_of(described_class).to receive(:authenticate_request!).and_return(true)
      allow_any_instance_of(described_class).to receive(:current_user).and_return(user)
      controller.instance_variable_set("@create_movie", UseCaseDummy)
      allow(UseCaseDummy).to receive(:call).and_return(movie)
      post_create
    end

    it { expect(response.status).to eq(201) }
    it { expect(json_body["name"]).to eq(movie[:name]) }
    it { expect(json_body).to match_schema("movie") }
  end

  describe "#update" do
    subject(:post_update) { post :update, params: params }

    let(:movie) { build(:movie) }
    let(:user) { build(:user) }
    let(:params) { movie.as_json.except(:rating, :user_id) }

    before do
      allow_any_instance_of(described_class).to receive(:authenticate_request!).and_return(true)
      allow_any_instance_of(described_class).to receive(:current_user).and_return(user)
      controller.instance_variable_set("@update_movie", UseCaseDummy)
      allow(UseCaseDummy).to receive(:call).and_return(movie)
      post_update
    end

    it { expect(response.status).to eq(200) }
    it { expect(json_body["name"]).to eq(movie[:name]) }
    it { expect(json_body).to match_schema("movie") }
  end

  describe "#destroy" do
    subject(:post_destroy) { post :destroy, params: params }

    let(:movie) { build(:movie) }
    let(:user) { build(:user) }
    let(:params) { movie.as_json.except(:rating, :user_id) }

    before do
      allow_any_instance_of(described_class).to receive(:authenticate_request!).and_return(true)
      allow_any_instance_of(described_class).to receive(:current_user).and_return(user)
      controller.instance_variable_set("@destroy_movie", UseCaseDummy)
      allow(UseCaseDummy).to receive(:call).and_return(movie)
      post_destroy
    end

    it { expect(response.status).to eq(200) }
    it { expect(json_body["name"]).to eq(movie[:name]) }
    it { expect(json_body).to match_schema("movie") }
  end
end
