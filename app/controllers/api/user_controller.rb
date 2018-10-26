class Api::UserController < ApplicationController

  def login
    user = User.find_by!(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: user
    else
      render_404
    end
  end

  def create
  end

  def logout
    reset_session
    render json: { ok: 1 }
  end

end
