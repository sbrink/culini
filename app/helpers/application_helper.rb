module ApplicationHelper

  def breadcrumb(*args)
    crumb = [["Startseite",root_path], args.flatten]
    str = crumb.map{|arr| link_to(arr[0], arr[1]) if arr[0].present? }.to_s
    content_for(:breadcrumb, raw(str))
  end

  def flash_messages
    flash.map { |name, msg| content_tag :div, msg, :class => "flash #{name}" }.join("").html_safe
  end

  def get_title(options={})
  end

  def param_filter(attribute)
    (params[:except].nil? || !params[:except].include?(attribute.to_s)) &&
    (params[:only].nil? || params[:only].include?(attribute.to_s))
  end

  def linebreaked(text)
    h(text).gsub("\n","<br/>").html_safe
  end

  def textilized_lite(text)
    RedCloth.new(text,[:lite_mode]).to_html.html_safe
  end

  def title(title,options={})
    @show_title = !(options[:hide] || false)
    options[:scope] = [:controllers,controller_name,:title]
    options[:default] = [:edit] if action_name == "update"
    options[:default] = [:new] if action_name == "create"
    options[:default]? options[:default] << title : options[:default] = title
    name = I18n.t("#{action_name}", options)
    content_for(:title) { name }
  end

  def get_crumb_name(name)
    controller, action = name.to_s.split('.')
    if controller == "self"
      controller = controller_name
      action = action || action_name
    end
    I18n.t("#{controller.pluralize}.title.#{action || "index"}", :scope => :controllers, :default => name.to_s)
  end

  def get_crumb_path(name)
    controller, action = name.to_s.split('.')
    controller = controller_name if controller == "self"
    action = nil if action == "index"
    [action,controller]
  end

  def crumb(*segments)
    a = []
    segments[0..-2].each do |segment|
      case segment
        when Symbol then a << link_to(get_crumb_name(segment), get_crumb_path(segment))
      end
    end
    a << get_crumb_name(segments[-1])
    content_for(:crumb) { a.join(' &gt; ') }
  end

  def number_to_euro(price)
    number_to_currency(price, :precision => 2,:unit => '&euro;', :separator => ",", :delimiter => "", :format => "%n %u")
  end

  def to_money(price_in_decimal)
    price_in_decimal ? number_to_euro(price_in_decimal) : "&nbsp;".html_safe
  end

  def to_time(time_in_decimal)
    ("%.02f" % time_in_decimal).sub('.',':')
  end

  def localize_price(price_in_decimal)
    if price_in_decimal > 0
      ("%.02f" % price_in_decimal).sub('.',',')
    else
      "0"
    end
  end

  def meta_tag(name, content)
    tag 'meta', { :name => name, :content => content }
  end

  def google_analytics(ua)
    %{ <script type="text/javascript">
       var _gaq = _gaq || [];
      _gaq.push(['_setAccount', '#{ua}']);
      _gaq.push(['_setDomainName', '.culini.de']);
      _gaq.push(['_trackPageview']);

      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();
      </script>
    }.html_safe if Rails.env == "production"
  end

  def link_to_new(*args, &block)
    args[0] = t("helpers.new", :model => t(args[0].to_s.underscore, :scope => "activerecord.models", :default => args[0].to_s.humanize))
    args.push(:class => "button")
    link_to(*args,block)
  end

end
