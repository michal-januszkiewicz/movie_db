# frozen_string_literal: true

describe Token::Forms::Update do
  subject(:validate) { described_class.call(params) }

  let(:params) do
    {
      user_id: user_id,
      revoked: revoked,
    }
  end

  let(:revoked) { true }
  let(:user_id) { SecureRandom.uuid }

  it { is_expected.to be_success }

  it_behaves_like "form validation for", :revoked, empty: false, without: false
  it_behaves_like "form validation for", :user_id, empty: false, without: false
end
