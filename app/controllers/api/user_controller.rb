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
    user = User.find_or_initialize_by(email: params[:email])
    if user.new_record?
      user.name = params[:name]
      user.password = params[:password]
      user.save
    end
    session[:user_id] = user.id
    render json: user
  end

  def logout
    reset_session
    render json: { ok: 1 }
  end

  def current_login_user
    user = User.find(session[:user_id])
    render json: user
  end

end
