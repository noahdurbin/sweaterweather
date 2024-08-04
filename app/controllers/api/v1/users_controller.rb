class Api::V1::UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    @user.api_key = generate_api_key
    if @user.save
      render json: UserSerializer.new(@user), status: :created
    else
      raise ActiveRecord::RecordInvalid.new(@user)
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user
      if user && user.authenticate(params[:password])
        render json: UserSerializer.new(user), status: :ok
      else
        render json: ErrorSerializer.new(ErrorMessage.new('Invalid Password', 401)), status: :unauthorized
      end
    else
      render json: ErrorSerializer.new(ErrorMessage.new('User Not Found', 404)), status: :not_found
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def generate_api_key
    SecureRandom.hex
  end
end
