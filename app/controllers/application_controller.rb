class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    dashboard_users_path
  end

  def owner?(user_id)
    signed_in? ? user_id == current_user.id : false
  end

  helper_method :owner?
end
