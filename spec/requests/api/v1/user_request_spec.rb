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

  describe 'user login' do
    it 'allows a user to login', :vcr do
      user_params = {
        email: 'user1@test.com',
        password: 'password',
        password_confirmation: 'password'
      }

      post api_v1_users_path, params: user_params
      expect(response).to have_http_status(:created)

      login_params = {
        email: 'user1@test.com',
        password: 'password'
      }

      post '/api/v1/sessions', params: login_params
      expect(response).to have_http_status(200)
      user = JSON.parse(response.body, symbolize_names: true)

      expect(user).to have_key :data
      expect(user[:data]).to have_key :type
      expect(user[:data][:type]).to eq "user"
      expect(user[:data]).to have_key :id
      expect(user[:data][:attributes][:email]).to eq "user1@test.com"
      expect(user[:data][:attributes]).to have_key :api_key
      expect(user[:data].count).to eq 3
    end

    it 'returns an error if password is incorrect' do
      user_params = {
        email: 'user1@test.com',
        password: 'password',
        password_confirmation: 'password'
      }

      post api_v1_users_path, params: user_params
      expect(response).to have_http_status(:created)

      login_params = {
        email: 'user1@test.com',
        password: 'paword'
      }
      post '/api/v1/sessions', params: login_params
      error = JSON.parse(response.body, symbolize_names: true)
      expect(error[:error][:message]).to eq "Invalid Password"
      expect(error[:error][:status]).to eq 401
    end

    it 'returns an error if the user does not exist/email is incorrect' do
      login_params = {
        email: 'user1@test.com',
        password: 'paword'
      }
      post '/api/v1/sessions', params: login_params
      error = JSON.parse(response.body, symbolize_names: true)
      expect(error[:error][:message]).to eq "User Not Found"
      expect(error[:error][:status]).to eq 404
    end
  end
end
