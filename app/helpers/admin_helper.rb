module AdminHelper
  def clippy(text, bgcolor='#FFFFFF')
    html = <<-EOF
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
              width="110"
              height="14"
              id="clippy" >
      <param name="movie" value="/flash/clippy.swf"/>
      <param name="allowScriptAccess" value="always" />
      <param name="quality" value="high" />
      <param name="scale" value="noscale" />
      <param NAME="FlashVars" value="text=#{text}">
      <param name="bgcolor" value="#{bgcolor}">
      <embed src="/flash/clippy.swf"
             width="110"
             height="14"
             name="clippy"
             quality="high"
             allowScriptAccess="always"
             type="application/x-shockwave-flash"
             pluginspage="http://www.macromedia.com/go/getflashplayer"
             FlashVars="text=#{text}"
             bgcolor="#{bgcolor}"
      />
      </object>
    EOF
  end
  safe_helper :clippy if respond_to? :safe_helper

  def make_sortable(id, path)
    render :partial => '/shared/make_sortable', :locals => { :id => id, :path => path }
  end
  safe_helper :make_sortable if respond_to? :safe_helper

  def toggle_visibility(object, path)
    render :partial => '/shared/toggle_visibility', :locals => { :object => object, :path => path }
  end
  safe_helper :toggle_visibility if respond_to? :safe_helper

  def destroy(object, path)
    render :partial => '/shared/destroy', :locals => { :object => object, :path => path }
  end
  safe_helper :destroy if respond_to? :safe_helper

  def shared_index(*args)
    columns = args.blank? ? [:name] : args
    render :partial => '/shared/index', :locals => { :columns => columns }
  end
  safe_helper :shared_index if respond_to? :safe_helper

  def edit(object, path, label_text = 'Edit')
    link_to(label_text, path, :id => dom_id(object), :class => "#{dom_class(object, 'edit')} btn")
  end
  safe_helper :edit if respond_to? :safe_helper

  def toggle_visibility_submit(object)
    object.is_visible ? content_tag(:p, button_submit_tag("Hide")) : content_tag(:p, button_submit_tag("Show"))
  end
  safe_helper :toggle_visibility_submit if respond_to? :safe_helper

  def button_submit_tag(content)
    content_tag(:button, content, :type => 'submit', :class => "btn")
  end
  safe_helper :button_submit_tag if respond_to? :safe_helper

  def create_button
    content_tag(:p, button_submit_tag('Create'))
  end

  def update_button
    content_tag(:p, button_submit_tag('Update'))
  end

  def calltoaction(*args)
    result = []
    args.each do |arg|
      result << arg
    end
    content_for(:calltoaction, result.join("\n").html_safe)
  end
  alias_method :cta, :calltoaction

  def heading(txt="", &block)
    content_for(:heading, (block_given? ? concat(capture(&block)) : txt).html_safe)
  end

  def visibility_class(boolean)
    boolean ? 'visible' : 'hidden'
  end

  def action_table_headings(t, options = {})
    t.header :toggle_visibility_action, '' unless options[:skip_visibility]
    t.header :edit_action, '' unless options[:skip_edit]
    t.header :destroy_action, '' unless options[:skip_destroy]
    t.rows[:id] = "#{resource_class.to_s.downcase}-rows"
  end
  safe_helper :action_table_headings if respond_to? :safe_helper

  def action_table_rows(row, item, options = {})
    row[:id] = dom_id(item)

    if options.has_key?(:visibility_boolean) || (item.respond_to?(:is_visible) && !options[:skip_visibility])
      visibility_boolean = options.has_key?(:visibility_boolean) ? options[:visibility_boolean] : item.is_visible
      row[:class] = visibility_class(visibility_boolean)
    end

    row.toggle_visibility_action toggle_visibility(item, toggle_visibility_resource_path(item)) unless options[:skip_visibility]
    row.edit_action              edit(item, edit_resource_path(item)) unless options[:skip_edit]
    row.destroy_action           destroy(item, resource_path(item)) unless options[:skip_destroy]
  end
  safe_helper :action_table_rows if respond_to? :safe_helper

  def is_visible_radio_buttons(form)
    form.input :is_visible, :as => :radio, :wrapper => :list, :label => "Visible?", :collection => [["Yes", true], ["No", false]]
  end
  safe_helper :is_visible_radio_buttons if respond_to? :safe_helper

  def nav_link_to(text, url, active_matches, match_against = controller.controller_name, options = {})
    content_tag(:li, link_to(text, url, { :title => text }), is_active?(match_against, active_matches))
  end

  def attachment_requirements(options = {})
    result = String.new
    result << attachment_dimensions(options[:dimensions]) + ' in ' if options[:dimensions]
    result << attachment_formats(options[:formats]) + '  format required' if options[:formats]
    result.html_safe
  end

  def attachment_dimensions(arr)
    if arr.length > 1
      dim = arr.collect { |d| d.to_s + 'px' }.join(' x ')
    else
      dim = arr.first.to_s  + 'px wide'
    end
    content_tag(:strong, 'at least ' + dim)
  end

  def attachment_formats(arr)
    content_tag(:strong, arr.to_sentence(:two_words_connector => ' or ', :last_word_connector => ', or '))
  end

  def markdown_preview_for(target)
    %{
      <div class="preview">
        <div class="result"></div>
        <div class="controls">
          <a href="#" class="show" rel="#{target.to_s}">Preview</a>
          <a href="#" class="cancel" rel="#{target.to_s}">Cancel</a>
        </div>
      </div>
    }.html_safe
  end

  def permalink_field_for(attribute, form)
    object_name = form.object.class.to_s.downcase
    render :partial => '/shared/permalink_field', :locals => { :form => form, :attribute => attribute, :object_name => object_name }
  end

  def image_preview(img)
    content_tag :p do
      content_tag(:strong, "Current Image:") + "<br />".html_safe + image_tag(img)
    end
  end

  def message(text)
    content_tag(:p, text, :class => "clear message")
  end
  safe_helper :message if respond_to? :safe_helper

  def overlay_for(id, title, content="", &block)
    content = content_tag(:div, content_tag(:div, (content_tag(:h3, title) + (block_given? ? capture(&block) : content))), :class => 'simple_overlay', :id => id.to_s)
    concat(content)
  end
  safe_helper :overlay_for if respond_to? :safe_helper
end