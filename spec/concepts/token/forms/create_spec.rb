# frozen_string_literal: true

describe Token::Forms::Create do
  subject(:validate) { described_class.call(params) }

  let(:params) do
    {
      value: value,
      user_id: user_id,
    }
  end

  let(:value) { "jwt_token" }
  let(:user_id) { SecureRandom.uuid }

  it { is_expected.to be_success }

  it_behaves_like "form validation for", :value, empty: false, without: false
  it_behaves_like "form validation for", :user_id, empty: false, without: false
end
