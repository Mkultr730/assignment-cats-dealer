class BestCatDealService
  attr_reader :cat_type, :location

  def initialize(cat_params)
    @cat_type = cat_params[:cats_type]
    @location = cat_params[:user_location]
  end

  def execute
    shops = ['CatsUnlimited', 'HappyCats']
    all_cats = shops.flat_map do |shop|
      CatShops::CatShopFactory.create(shop).fetch_cats
    end

    best_deal = all_cats.select do |cat|
      cat['location'] == location && cat['name'] == cat_type
    end.sort_by { |cat| cat['price'] }.first

    if best_deal
      return { data: best_deal }
    end
      
    return { message: 'No deals available at this time' }
  end
end