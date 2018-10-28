module ApplicationHelper

  def isLogin?
    session[:user_id].present?
  end

  def check_login
    return render json: { error: 'you must login!!!' } unless isLogin?
  end

end
