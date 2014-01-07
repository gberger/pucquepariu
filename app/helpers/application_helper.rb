module ApplicationHelper
  def active_page(*args)
    if current_page?(*args)
      'active'
    else
      ''
    end
  end
end
