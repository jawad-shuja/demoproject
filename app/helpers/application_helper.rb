module ApplicationHelper
  def valid_user?(item, user)
    item.user == user
  end
end
