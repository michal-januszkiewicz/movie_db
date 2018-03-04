# frozen_string_literal: true

describe Movie::Forms::Create do
  subject(:validate) { described_class.call(params) }

  let(:params) do
    {
      name: name,
      description: description,
      categories: categories,
      user_id: user_id,
    }
  end

  let(:name) { "Arrival" }
  let(:description) { "Cool movie" }
  let(:categories) { ["Science Fiction"] }
  let(:user_id) { SecureRandom.uuid }

  it { is_expected.to be_success }

  it_behaves_like "form validation for", :name, empty: false, without: false
  it_behaves_like "form validation for", :description, empty: false, without: true
  it_behaves_like "form validation for", :categories, empty: true, without: true
  it_behaves_like "form validation for", :user_id, empty: false, without: false

  context "when category is not on the list" do
    let(:categories) { ["Romance"] }

    it { expect(validate.errors.keys).to match_array([:categories]) }
  end
end
