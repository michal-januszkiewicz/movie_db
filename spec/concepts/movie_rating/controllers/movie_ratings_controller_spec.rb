# frozen_string_literal: true

require "./spec/dummies/use_case_dummy"

describe MovieRating::Controllers::MovieRatingsController, type: :controller do
  describe "#create" do
    subject(:post_create) { post :create, params: params }

    let(:movie_rating) { build(:movie_rating) }
    let(:params) { movie_rating.as_json.except(:id, :user_id) }
    let(:user) { build(:user) }

    before do
      # TODO: Extract authentication mock to a helper.
      allow_any_instance_of(described_class).to receive(:authenticate_request!).and_return(true)
      allow_any_instance_of(described_class).to receive(:current_user).and_return(user)
      controller.instance_variable_set("@create_movie_rating", UseCaseDummy)
      allow(UseCaseDummy).to receive(:call).and_return(movie_rating)
      post_create
    end

    it { expect(response.status).to eq(201) }
    it { expect(json_body["value"]).to eq(movie_rating[:value]) }
    it { expect(json_body).to match_schema("movie_rating") }
  end
end
