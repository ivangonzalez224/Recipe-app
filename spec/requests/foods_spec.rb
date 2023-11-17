require 'rails_helper'

RSpec.describe 'FoodsController', type: :request do
  describe 'GET #index' do
    it 'returns a successful response' do
      get '/'
      expect(response).to have_http_status(200)
    end

    it 'returns an error response for a wrong path' do
      get '/failed_path'
      expect(response).to have_http_status(404)
    end

    it 'should redirects to the sign in page for an unauthenticated user' do
      get '/foods'
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
