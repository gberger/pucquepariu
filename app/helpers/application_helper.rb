module ApplicationHelper
  def active_page(*args)
    if current_page?(*args)
      'active'
    else
      ''
    end
  end

  def markdown(text)
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true, no_intra_emphasis: true)
    md.render(h text).html_safe
  end

  def facebook_url_to(username)
    "https://facebook.com/#{username}"
  end

  def facebook_link_to(username)
    link_to username, facebook_url_to(username)
  end
end
