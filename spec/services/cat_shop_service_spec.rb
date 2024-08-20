require 'rails_helper'

describe CatShopService do
    describe '#fetch_cats' do
    it 'raises a NotImplementedError' do
      service = CatShopService.new
      
      expect { service.fetch_cats }.to raise_error(NotImplementedError, "This CatShopService cannot respond to:")
    end
  end
end