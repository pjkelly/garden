module SiteHelper

  def flash_messages(flash)
    res = String.new
    flash.each do |key, msg|
      res << "<div class=\"message #{key.to_s}\">#{msg}</div>".html_safe unless msg.blank?
    end
    res.html_safe
  end

  def is_active?(cond1, cond2, res = {:class => 'active'})
    if cond2.is_a?(Array)
      cond2.include?(cond1) ? res : {}
    elsif cond2.is_a?(String) || cond2.is_a?(TrueClass) || cond2.is_a?(FalseClass)
      (cond1 == cond2) ? res : {}
    else
      {}
    end
  end

  def body_class
    classes = []
    classes << controller.controller_name
    classes << "#{controller.controller_name}-#{controller.action_name}"
    classes.join(' ')
  end

  def google_analytics_tracking_code(code = 'UA-XXXXXX-XX')
    if Rails.env.production?
      code = <<-HERE

    <script>
      var _gaq=[["_setAccount","#{code}"],["_trackPageview"]];
      (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];g.async=1;
      g.src=("https:"==location.protocol?"//ssl":"//www")+".google-analytics.com/ga.js";
      s.parentNode.insertBefore(g,s)}(document,"script"));
    </script>
HERE
      code.html_safe
    end
  end
end
