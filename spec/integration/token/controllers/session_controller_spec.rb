# frozen_string_literal: true

describe Token::Controllers::SessionController, type: :request do
  include SpecHelpers::JwtToken

  describe "#create" do
    subject(:post_create) { post "/api/v1/session", params: params }

    context "when token is valid" do
      let(:user) { build(:user, :persisted) }
      let(:params) { { token: generate_token(email: user[:email]) } }

      it "returns HTTP status 201" do
        post_create
        expect(response.status).to eq(201)
      end
    end

    context "when token is invalid" do
      let(:params) { { token: "invalid_token" } }

      it "returns HTTP status 401" do
        post_create
        expect(response.status).to eq(401)
      end
    end
  end

  describe "#destroy" do
    subject(:post_destroy) { delete "/api/v1/session", headers: headers }

    before { post_destroy }

    context "when authenticated" do
      let(:user) { build(:user, :persisted) }
      let(:headers) { { "Authorization" => "Token #{token[:value]}" } }

      context "when token is active" do
        let(:token) { build(:token, :persisted, user: user) }

        it { expect(response.status).to eq(200) }
        it { expect(json_body["revoked"]).to eq(true) }
      end

      context "when token has already been revoked" do
        let(:token) { build(:token, user: user, revoked: true) }

        it { expect(response.status).to eq(401) }
      end
    end

    context "when unauthenticated" do
      let(:headers) { {} }

      it { expect(response.status).to eq(401) }
    end
  end
end
