require 'rails_helper'

describe CatsController do
  describe 'GET #best_deal' do
    
    context 'when there is no error' do
      let(:params) { { cats_type: 'Siamese', user_location: 'New York' } }
      let(:service_result) do 
        {
          best_deal: {
            name: 'Siamese',
            location: 'New York',
            price: 500
          }
        }
      end

      before do
        allow_any_instance_of(BestCatDealService).to receive(:execute).and_return(service_result)
      end

      it 'returns a successful response' do
        get :best_deal, params: params
        expect(response).to have_http_status(:ok)
      end

      it 'calls BestCatDealService with correct parameters' do
        expect(BestCatDealService).to receive(:new).with(ActionController::Parameters.new(params).permit!).and_call_original
        get :best_deal, params: params
      end

      it 'renders the correct JSON response' do
        get :best_deal, params: params
        expected_response = {
          status: 'success',
          best_deal: {
            name: 'Siamese',
            location: 'New York',
            price: 500
          }
        }.to_json
        expect(response.body).to eq(expected_response)
      end
    end

    context 'when a RestClient::ExceptionWithResponse is raised' do
      before do
        allow(RestClient).to receive(:get).and_raise(RestClient::ExceptionWithResponse.new('Service error'))
      end

      it 'handles the service error and returns an appropriate error message' do
        get :best_deal, params: { cats_type: 'Siamese', user_location: 'New York' }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Service error')
      end
    end

    context 'when a SocketError is raised' do
      before do
        allow(RestClient).to receive(:get).and_raise(SocketError.new('Network error'))
      end

      it 'handles the network error and returns an appropriate error message' do
        get :best_deal, params: { cats_type: 'Siamese', user_location: 'New York' }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Network error')
      end
    end
  end
end
