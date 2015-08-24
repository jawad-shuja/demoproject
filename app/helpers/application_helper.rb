module ApplicationHelper
  def flash_class_for(flash_type)
    case flash_type
    when :notice
      "alert-info"
    when :alert
      "alert-warning"
    when :success
      "alert-success"
    when :error
      "alert-danger"
    else
      flash_type.to_s
    end
  end
end
