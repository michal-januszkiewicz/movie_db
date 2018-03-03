# frozen_string_literal: true

describe Movie::Repository do
  describe "#one_by_id" do
    subject(:call_method) { described_class.new(ROM.env).one_by_id(id) }

    context "when movie exists" do
      let(:movie) { build(:movie, :persisted) }
      let(:id) { movie[:id] }

      it { expect(call_method[:id]).to eq(movie[:id]) }
    end

    context "when movie doesn't exist" do
      let(:id) { -1 }

      it { expect(call_method).to be_nil }
    end
  end

  describe "#all" do
    subject(:call_method) { described_class.new(ROM.env).all(params) }

    let(:user) { build(:user, :persisted) }
    let(:movies) do
      Array.new(3) do
        build(:movie, :persisted, user_id: user[:id], rating: 1, categories: ["Drama"])
      end
    end

    before { movies }

    context "when listing all movies" do
      let(:params) { {} }

      it "returns all movies" do
        result = call_method
        expect(result.pluck(:id)).to match_array(movies.pluck(:id))
      end
    end

    context "when searching by name" do
      let(:params) { { search: "Matri" } }
      let!(:searched_movie) { build(:movie, :persisted, name: "Matrix", user_id: user[:id]) }

      it "returns only movies matching the search pattern" do
        result = call_method
        expect(result.pluck(:id)).to match_array(searched_movie[:id])
      end
    end

    context "when filtering by category" do
      let(:params) { { category_filter: "Action" } }
      let!(:filtered_movie) do
        build(:movie, :persisted, user_id: user[:id], categories: ["Action"])
      end

      it "returns only movies matching the search pattern" do
        result = call_method
        expect(result.pluck(:id)).to match_array(filtered_movie[:id])
      end
    end

    context "when filtering by rating" do
      let(:params) { { rating_filter: 5 } }
      let!(:filtered_movie) { build(:movie, :persisted, user_id: user[:id], rating: 5) }

      it "returns only movies matching the search pattern" do
        result = call_method
        expect(result.pluck(:id)).to match_array(filtered_movie[:id])
      end
    end

    context "when filtering by category and rating" do
      let(:params) { { category_filter: "Action", rating_filter: 5 } }
      let!(:filtered_movie) do
        build(:movie, :persisted, user_id: user[:id], categories: ["Action"], rating: 5)
      end

      it "returns only movies matching the search pattern" do
        result = call_method
        expect(result.pluck(:id)).to match_array(filtered_movie[:id])
      end
    end

    context "when searching and filtering by category and rating" do
      let(:params) { { search: "Gat", category_filter: "Action", rating_filter: 5 } }
      let!(:filtered_movie) do
        build(
          :movie, :persisted, user_id: user[:id], name: "Gattaca", categories: ["Action"], rating: 5
        )
      end

      it "returns only movies matching the search pattern" do
        result = call_method
        expect(result.pluck(:id)).to match_array(filtered_movie[:id])
      end
    end
  end
end
