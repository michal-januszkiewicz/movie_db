# frozen_string_literal: true

describe Movie::Forms::Index do
  subject(:validate) { described_class.call(params) }

  let(:params) do
    {
      search: search,
      category_filter: category_filter,
      rating_filter: rating_filter,
    }
  end

  let(:search) { "Blade Runner" }
  let(:category_filter) { "Science Fiction" }
  let(:rating_filter) { 5 }

  it { is_expected.to be_success }

  it_behaves_like "form validation for", :search, empty: false, without: true
  it_behaves_like "form validation for", :category_filter, empty: false, without: true
  it_behaves_like "form validation for", :rating_filter, empty: false, without: true

  context "when category is not on the list" do
    let(:category_filter) { "Romance" }

    it { expect(validate.errors.keys).to match_array([:category_filter]) }
  end

  context "when rating is beyond scale" do
    let(:rating_filter) { 6 }

    it { expect(validate.errors.keys).to match_array([:rating_filter]) }
  end
end
