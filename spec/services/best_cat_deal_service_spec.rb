require 'rails_helper'

describe BestCatDealService do
  let(:cat_params) { { cats_type: 'Siamese', user_location: 'New York' } }
  let(:service) { described_class.new(cat_params) }

  describe '#initialize' do
    it 'assigns @cat_type and @location' do
      expect(service.cat_type).to eq('Siamese')
      expect(service.location).to eq('New York')
    end
  end

  describe '#execute' do
    context 'when a matching cat is found' do
      let(:cats_unlimited_cats) do
        [
          { 'name' => 'Siamese', 'location' => 'New York', 'price' => 400 },
          { 'name' => 'Persian', 'location' => 'New York', 'price' => 350 }
        ]
      end

      let(:happy_cats_cats) do
        [
          { 'name' => 'Siamese', 'location' => 'New York', 'price' => 300 },
          { 'name' => 'Siamese', 'location' => 'Los Angeles', 'price' => 200 }
        ]
      end

      before do
        allow(CatShops::CatShopFactory).to receive(:create)
          .with('CatsUnlimited').and_return(double(fetch_cats: cats_unlimited_cats))
        allow(CatShops::CatShopFactory).to receive(:create)
          .with('HappyCats').and_return(double(fetch_cats: happy_cats_cats))
      end

      it 'returns the best deal' do
        result = service.execute
        expected_result = { data: { 'name' => 'Siamese', 'location' => 'New York', 'price' => 300 } }
        expect(result).to eq(expected_result)
      end
    end

    context 'when no matching cat is found' do
      let(:cats_unlimited_cats) { [] }
      let(:happy_cats_cats) { [] }

      before do
        allow(CatShops::CatShopFactory).to receive(:create)
          .with('CatsUnlimited').and_return(double(fetch_cats: cats_unlimited_cats))
        allow(CatShops::CatShopFactory).to receive(:create)
          .with('HappyCats').and_return(double(fetch_cats: happy_cats_cats))
      end

      it 'returns a message indicating no deals available' do
        result = service.execute
        expected_result = { message: 'No deals available at this time' }
        expect(result).to eq(expected_result)
      end
    end
  end
end