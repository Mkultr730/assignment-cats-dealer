class CatShops::CatShopFactory
  def self.create(shop_name)
    case shop_name
    when 'CatsUnlimited'
      CatShops::CatsUnlimitedService.new
    when 'HappyCats'
      CatShops::HappyCatsService.new
    else
      raise "Unsupported shop: #{shop_name}"
    end
  end
end