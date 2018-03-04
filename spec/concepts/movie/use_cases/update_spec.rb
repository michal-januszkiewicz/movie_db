# frozen_string_literal: true

require "./spec/dummies/form_dummy"
require "./spec/dummies/repository_dummy"

describe Movie::UseCases::Update do
  subject(:call_use_case) do
    described_class.new(update_form: FormDummy, movie_repository: RepositoryDummy).call(params)
  end

  let(:user) { build(:user) }
  let(:movie) { build(:movie, user_id: user[:id]) }
  let(:params) { movie.as_json.symbolize_keys.except(:rating) }

  before do
    allow(FormDummy).to receive(:call).and_return(FormDummy)
    allow(FormDummy).to receive(:failure?).and_return(false)
    allow(FormDummy).to receive(:output).and_return(params)
    allow(RepositoryDummy).to receive(:update).and_return(nil)
  end

  context "when movie doesn't exist" do
    before { allow(RepositoryDummy).to receive(:one_by_id).and_return(nil) }

    it { expect { call_use_case }.to raise_error(Errors::NotFound) }
  end

  context "when user is not authorized" do
    let(:params) { super().merge(user_id: build(:user)[:id]) }

    before { allow(RepositoryDummy).to receive(:one_by_id).and_return(movie) }

    it { expect { call_use_case }.to raise_error(Errors::Unauthorized) }
  end

  context "when movie exists" do
    before do
      allow(RepositoryDummy).to receive(:one_by_id).and_return(movie)
      call_use_case
    end

    context "when using validator" do
      it { expect(FormDummy).to have_received(:call).with(params) }
      it { expect(FormDummy).to have_received(:failure?) }
      it { expect(FormDummy).to have_received(:output) }
    end

    it "calls the repository to fetch data" do
      expect(RepositoryDummy).to have_received(:update).with(
        params[:id], params.except(:id, :user_id)
      )
    end
  end
end
