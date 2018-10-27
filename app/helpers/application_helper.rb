module ApplicationHelper

  def isLogin?
    session[:user_id].present?
  end

end
