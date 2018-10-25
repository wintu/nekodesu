class Api::UserController < ApplicationController

  def login
    user = User.find_by(email: params[:email])
    return render json: { error: 'not found' } if user.blank?
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: user
    else
      render json: { error: 'not found' }
    end
  end

  def logout
    reset_session
    render json: { ok: 1 }
  end

end
