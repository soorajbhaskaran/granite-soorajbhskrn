# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate_user_using_x_auth_token

  def create
    @user = User.find_by!(user_params[:email])
    unless @user.authenticate(params[:password])
      respond_with_error(t("session.incorrect_credentials"), :unauthorized)
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end
end
