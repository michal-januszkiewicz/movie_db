# frozen_string_literal: true

describe Movie::Forms::Update do
  subject(:validate) { described_class.call(params) }

  let(:params) do
    {
      id: id,
      name: name,
      description: description,
      categories: categories,
    }
  end

  let(:id) { 1 }
  let(:name) { "Arrival" }
  let(:description) { "Cool movie" }
  let(:categories) { ["Science Fiction"] }

  it { is_expected.to be_success }

  it_behaves_like "form validation for", :id, empty: false, without: false
  it_behaves_like "form validation for", :name, empty: false, without: true
  it_behaves_like "form validation for", :description, empty: true, without: true
  it_behaves_like "form validation for", :categories, empty: true, without: true

  context "when category is not on the list" do
    let(:categories) { ["Romance"] }

    it { expect(validate.errors.keys).to match_array([:categories]) }
  end
end
