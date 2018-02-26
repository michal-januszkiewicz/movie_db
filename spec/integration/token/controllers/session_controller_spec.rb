# frozen_string_literal: true

describe Token::Controllers::SessionController, type: :request do
  include SpecHelpers::JwtToken

  describe "#create" do
    subject(:post_create) { post "/api/v1/session", params: params }

    context "when token is valid" do
      let(:user) { build(:user) }
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
end
