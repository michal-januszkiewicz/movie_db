# frozen_string_literal: true

describe RatingUpdater::Service do
  subject(:call_service) do
    described_class.new(
      rating_repository: RepositoryDummy, movie_repository: RepositoryDummy,
    ).call(movie[:id])
  end

  let(:movie) { build(:movie) }

  before do
    allow(RepositoryDummy).to receive(:all_for_movie).and_return(ratings)
    allow(RepositoryDummy).to receive(:update).and_return(nil)
  end

  context "when the first rating is added" do
    let(:ratings) { [{ value: 5 }] }

    before { call_service }
    it "updates the movie with new rating" do
      expect(RepositoryDummy).to have_received(:update).with(movie[:id], rating: ratings[0][:value])
    end
  end

  context "when there are many ratings" do
    let(:ratings) { [{ value: 5 }, { value: 5 }, { value: 4 }] }

    before { call_service }
    it "updates the movie with new rating" do
      expect(RepositoryDummy).to have_received(:update).with(movie[:id], rating: 5)
    end
  end
end
