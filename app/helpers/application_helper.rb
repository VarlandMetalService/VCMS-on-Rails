module ApplicationHelper
  
  def bootstrap_class_for flash_type
    case flash_type
      when 'success'
        'alert-success'
      when 'error'
        'alert-danger'
      when 'alert'
        'alert-warning'
      when 'danger'
        'alert-warning'
      when 'notice'
        'alert-info'
      else
        flash_type.to_s
    end
  end
  
  def primary_nav_link controller, action, text
    content_tag :li, class: (params[:controller] == controller && params[:action] == action ? 'active' : nil) do
      link_to text, { controller: controller, action: action }
    end
  end
  
  def access_level(right)
    current_user.permissions.find_by_permission right
  end
  
  def full_title(page_title = '')
    base_title = 'VCMS'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
  
end