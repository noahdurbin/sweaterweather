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
  end
end
