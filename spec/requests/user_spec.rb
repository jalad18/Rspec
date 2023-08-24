require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    it 'returns a success response' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'renders JSON containing all users' do
      FactoryBot.create_list(:user, 3)
      get users_path
      users = JSON.parse(response.body)
      expect(users.size).to eq(3)
    end
  end

  describe 'GET #show' do
    it 'returns a successfull response' do
      user = FactoryBot.create(:user)
      get user_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'reders Json containing the requested user' do
      user = FactoryBot.create(:user)
      get user_path(user)
      user_response = JSON.parse(response.body)
      expect(user_response['name']).to eq(user.name)
    end
  end

  describe 'POST #create' do
    it 'creates a new user' do
      user_params = FactoryBot.attributes_for(:user)
      expect {
        post users_path, params: { user: user_params }
      }.to change(User, :count).by(1)
    end
  
    it 'returns the newly created user' do
      user_params = FactoryBot.attributes_for(:user)
      post users_path, params: { user: user_params }
      user_response = JSON.parse(response.body)
      expect(user_response['name']).to eq(user_params[:name])
    end
  
    it 'returns unprocessable_entity status if user creation fails' do
      post users_path, params: { user: { name: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST #create' do
    context 'with invalid parameters' do
      it 'does not create a new user' do
        expect {
          post users_path, params: { user: { name: '', email: '', password: '', phone: 'invalid' } }
        }.not_to change(User, :count)
      end

      it 'returns unprocessable_entity status' do
        post users_path, params: { user: { name: '', email: '', password: '', phone: 'invalid' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns JSON with error messages' do
        post users_path, params: { user: { name: '', email: '', password: '', phone: 'invalid' } }
        error_response = JSON.parse(response.body)
        expect(error_response).to have_key('name')
        expect(error_response).to have_key('email')
        expect(error_response).to have_key('password')
        expect(error_response).to have_key('phone')
      end
    end
  end
  # Other tests for show, create, update, destroy actions can be added similarly
end
