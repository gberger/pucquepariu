module ApplicationHelper
  def active_page(*args)
    if current_page?(*args)
      'active'
    else
      ''
    end
  end

  def markdown(text)
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true, no_intra_emphasis: true)
    html = renderer.render text

    doc = Nokogiri::HTML(html)
    doc.css('a').each do |a|
      a["target"] = "_blank"
    end
    
    doc.css('body').to_s.html_safe
  end

  def facebook_url_to(username)
    "https://facebook.com/#{username}"
  end

  def facebook_link_to(username, icon=true)
    text = if icon
             fa('facebook-square', fw: true) + " /#{username}"
           else
             username
           end
    link_to text, facebook_url_to(username)
  end

  def div_link(text)
    (text + content_tag(:span, '', class: 'div-link')).html_safe
  end
end
