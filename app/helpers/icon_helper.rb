module IconHelper
  def glyph(*names)
    content_tag :i, nil, class: ["glyphicon"] + names.map{|name| "glyphicon-#{name.to_s.gsub('_','-')}" } + ' '
  end

  # Creates an icon tag given an icon name and possible icon
  # modifiers.
  #
  # Examples
  #
  #   fa "camera-retro"
  #   # => <i class="fa fa-camera-retro"></i>
  #
  #   fa "camera-retro", text: "Take a photo"
  #   # => <i class="fa fa-camera-retro"></i> Take a photo
  #
  #   fa "camera-retro 2x"
  #   # => <i class="fa fa-camera-retro fa-2x"></i>
  #   fa ["camera-retro", "4x"]
  #   # => <i class="fa fa-camera-retro fa-4x"></i>
  #   fa "spinner spin lg"
  #   # => <i class="fa fa-spinner fa-spin fa-lg">
  #
  #   fa "quote-left 4x", class: "pull-left"
  #   # => <i class="fa fa-quote-left fa-4x pull-left"></i>
  #
  #   fa "user", data: { id: 123 }
  #   # => <i class="fa fa-user" data-id="123"></i>
  #
  #   content_tag(:li, fa("check li", text: "Bulleted list item"))
  #   # => <li><i class="fa fa-check fa-li"></i> Bulleted list item</li>
  def fa(names = "flag", options = {})
    classes = ["fa"]
    classes.concat Private.icon_names(names)
    classes.concat Array(options.delete(:class))
    classes.push "fa-fw" if options[:fw]
    text = options.delete(:text)
    icon = content_tag(:i, nil, options.merge(:class => classes))
    Private.icon_join(icon, text) + ' '
  end

  # Creates an stack set of icon tags given a base icon name, a main icon
  # name, and possible icon modifiers.
  #
  # Examples
  #
  #   fa_stacked_icon "twitter", base: "square-o"
  #   # => <span class="fa-stack">
  #   # =>   <i class="fa fa-square-o fa-stack-2x"></i>
  #   # =>   <i class="fa fa-twitter fa-stack-1x"></i>
  #   # => </span>
  #
  #   fa_stacked_icon "terminal inverse", base: "square", class: "pull-right", text: "Hi!"
  #   # => <span class="fa-stack pull-right">
  #   # =>   <i class="fa fa-square fa-stack-2x"></i>
  #   # =>   <i class="fa fa-terminal fa-inverse fa-stack-1x"></i>
  #   # => </span> Hi!
  #
  #   fa_stacked_icon "camera", base: "ban-circle", reverse: true
  #   # => <span class="fa-stack">
  #   # =>   <i class="fa fa-camera fa-stack-1x"></i>
  #   # =>   <i class="fa fa-ban-circle fa-stack-2x"></i>
  #   # => </span>
  def fa_stacked(names = "flag", options = {})
    classes = Private.icon_names("stack").concat(Array(options.delete(:class)))
    base_names = Private.array_value(options.delete(:base) || "square-o").push("stack-2x")
    names = Private.array_value(names).push("stack-1x")
    base = fa(base_names, options.delete(:base_options) || {})
    icon = fa(names, options.delete(:icon_options) || {})
    icons = [base, icon]
    icons.reverse! if options.delete(:reverse)
    text = options.delete(:text)
    stacked_icon = content_tag(:span, safe_join(icons), options.merge(:class => classes))
    Private.icon_join(stacked_icon, text)
  end

  def i_edit(text = 'Edit')
    fa('pencil') + " #{text}"
  end

  def i_add(text = 'New')
    fa('plus') + " #{text}"
  end

  def i_delete(text = 'Delete')
    fa('trash-o') + " #{text}"
  end

  module Private
    extend ActionView::Helpers::OutputSafetyHelper

    def self.icon_join(icon, text)
      return icon if text.blank?
      safe_join([icon, ERB::Util.html_escape(text)], " ")
    end

    def self.icon_names(names = [])
      array_value(names).map { |n| "fa-#{n}" }
    end

    def self.array_value(value = [])
      value.is_a?(Array) ? value : value.to_s.split(/\s+/)
    end
  end
end
