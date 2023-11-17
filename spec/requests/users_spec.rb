require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  describe 'GET #users' do
    it 'returns a successful response' do
      get '/users/sign_up'
      expect(response).to have_http_status(200)
    end
  end
end  