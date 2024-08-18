class BestDealService
  def get_best_deal(cat_type, location)
    shops = ['CatsUnlimited', 'HappyCats']
    all_cats = shops.flat_map do |shop|
      CatShopFactory.create(shop).fetch_prices
    end

    all_cats.select do |cat|
      cat['location'] == location && cat['name'] == cat_type
    end.sort_by { |cat| cat['price'] }
  end
end