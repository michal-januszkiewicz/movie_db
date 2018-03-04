# frozen_string_literal: true

require "./spec/dummies/form_dummy"
require "./spec/dummies/repository_dummy"

describe Movie::UseCases::Create do
  subject(:call_use_case) do
    described_class.new(create_form: FormDummy, movie_repository: RepositoryDummy).call(params)
  end

  let(:movie) { build(:movie) }
  let(:params) { movie.as_json.except(:id, :rating) }

  before do
    allow(FormDummy).to receive(:call).and_return(FormDummy)
    allow(FormDummy).to receive(:failure?).and_return(false)
    allow(FormDummy).to receive(:output).and_return(params)
    allow(RepositoryDummy).to receive(:create).and_return([])
    call_use_case
  end

  context "when using validator" do
    it { expect(FormDummy).to have_received(:call).with(params) }
    it { expect(FormDummy).to have_received(:failure?) }
    it { expect(FormDummy).to have_received(:output) }
  end

  it "calls the repository to fetch data" do
    expect(RepositoryDummy).to have_received(:create).with(params)
  end
end
