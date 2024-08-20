require 'swagger_helper'

RSpec.describe 'Cats API', type: :request do
  path '/cats/best_deal' do
    get 'Retrieves best deal' do
      tags 'Cats'
      parameter name: :cats_type, in: :query, type: :string, description: 'Cat Type'
      parameter name: :user_location, in: :query, type: :string, description: 'User Location'
      produces 'application/json'

      response '200', 'cats found' do
        schema type: :object,
              properties: {
                status: { type: :string },
                data: {
                  type: :object,
                  properties: {
                    name: { type: :string },
                    location: { type: :string },
                    price: { type: :number, format: :float },
                    image: { type: :string }
                  }
                }
              }

        xit
      end
    end
  end
end