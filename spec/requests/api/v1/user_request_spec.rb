require 'rails_helper'

RSpec.describe "User api endpoints" do
  describe 'create a new user' do
    it 'allows a user to create a user', :vcr do
      user_params = {
        email: 'user1@test.com',
        password: 'password',
        password_confirmation: 'password'
      }

      post api_v1_users_path, params: user_params
      expect(response).to have_http_status(:created)

      user = User.last
      expect(user.email).to eq("user1@test.com")
    end

    it 'returns an error if there is a user with the same email' do
      user_params = {
        email: 'user1@test.com',
        password: 'password',
        password_confirmation: 'password'
      }

      post api_v1_users_path, params: user_params
      expect(response).to have_http_status(:created)

      post api_v1_users_path, params: user_params
      expect(response.status).to eq(422)

      json_response = JSON.parse(response.body)
      expect(json_response['errors'].first['message']).to eq("Email has already been taken")
    end

    it 'returns an unprocessable entity error' do
      mismatched_password_params = {
        email: 'user1@test.com',
        password: 'password',
        password_confirmation: 'paword'
      }

      post api_v1_users_path, params: mismatched_password_params

      expect(response).to have_http_status(:unprocessable_entity)

      json_response = JSON.parse(response.body)
      expect(json_response['errors'].first['message']).to include("Password confirmation doesn't match Password")
      expect(json_response['errors'].first['status']).to eq("422")
    end
  end
end
