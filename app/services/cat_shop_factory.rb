class CatShopFactory
  def self.create(shop_name)
    case shop_name
    when 'CatsUnlimited'
      CatsUnlimitedService.new
    when 'HappyCats'
      HappyCatsService.new
    else
      raise "Unsupported shop: #{shop_name}"
    end
  end
end