class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    if resource_class == AdminUser
      admin_dashboard_path
    elsif resource_class == User
      if session[:checkout]
        session.delete(:checkout)
        checkout_orders_path
      else
        dashboard_users_path
      end
    end

  end

  def owner?(user_id)
    user_signed_in? ? user_id == current_user.id : false
  end

  helper_method :owner?
end
