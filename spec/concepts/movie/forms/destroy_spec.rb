# frozen_string_literal: true

describe Movie::Forms::Destroy do
  subject(:validate) { described_class.call(params) }

  let(:params) do
    {
      id: id,
    }
  end

  let(:id) { 1 }

  it { is_expected.to be_success }

  it_behaves_like "form validation for", :id, empty: false, without: false
end
