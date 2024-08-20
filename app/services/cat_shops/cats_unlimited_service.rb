class CatShops::CatsUnlimitedService < CatShopService
    def fetch_cats
      response = RestClient.get(ENV['CATS_UNLIMITED_API_URL'])
      cats = JSON.parse(response.body)
      cats.each do |cat|
        cat['price'] = cat['price'].to_i
      end
    end
  end