require 'rails_helper'

describe CatShops::CatShopFactory do
  describe '.create' do
    context 'when the shop name is CatsUnlimited' do
      it 'returns an instance of CatShops::CatsUnlimitedService' do
        service = CatShops::CatShopFactory.create('CatsUnlimited')
        expect(service).to be_an_instance_of(CatShops::CatsUnlimitedService)
      end
    end

    context 'when the shop name is HappyCats' do
      it 'returns an instance of CatShops::HappyCatsService' do
        service = CatShops::CatShopFactory.create('HappyCats')
        expect(service).to be_an_instance_of(CatShops::HappyCatsService)
      end
    end

    context 'when the shop name is unsupported' do
      it 'raises an error' do
        expect { CatShops::CatShopFactory.create('UnsupportedShop') }
          .to raise_error("Unsupported shop: UnsupportedShop")
      end
    end
  end
end