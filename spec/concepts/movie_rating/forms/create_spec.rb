# frozen_string_literal: true

describe MovieRating::Forms::Create do
  subject(:validate) { described_class.call(params) }

  let(:params) do
    {
      user_id: user_id,
      movie_id: movie_id,
      value: value,
    }
  end

  let(:user_id) { SecureRandom.uuid }
  let(:movie_id) { 1 }
  let(:value) { 2 }

  it { is_expected.to be_success }

  it_behaves_like "form validation for", :user_id, empty: false, without: false
  it_behaves_like "form validation for", :movie_id, empty: false, without: false
  it_behaves_like "form validation for", :value, empty: false, without: false

  context "when rating value is beyond scale" do
    let(:value) { 6 }

    it { expect(validate.errors.keys).to match_array([:value]) }
  end
end
