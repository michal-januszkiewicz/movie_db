# frozen_string_literal: true

RSpec.shared_examples "form validation for" do |param, options|
  context "without #{param}" do
    before { params.delete(param) }
    it { is_expected.to options[:without] ? be_success : be_failure }
  end

  context "with empty #{param}" do
    let(param) { "" }

    it { is_expected.to options[:empty] ? be_success : be_failure }
  end
end
