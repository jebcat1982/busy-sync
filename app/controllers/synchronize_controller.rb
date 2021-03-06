class SynchronizeController < ApplicationController
  def create
    user = User.from_omniauth(env['omniauth.auth'], current_user: current_user)
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
