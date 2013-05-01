module ApplicationHelper
  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def markdown(text)
    Redcarpet.new(text, :hard_wrap, :filter_html, :autolink).to_html.html_safe
  end

  def contact_us_email
    'help@msfaccess.org'
  end

  def link_to_top(top = 'branding')
    link_to('&uarr; Back to Top'.html_safe, { :anchor => top })
  end

  def link_to_square(square)
    html_classes = ['btn', 'btn-small']
    html_classes << 'btn-success' if square.current_planting
    background_color = (square.current_planting && !square.current_planting.transplant?) ? %{style="background-color: #{square.current_planting.seed.category.try(:color)}"} : ''
    tooltip = square.current_planting ? %{ rel="tooltip" data-original-title="#{square.current_planting.name}"} : ''
    %{
      <a href="#{box_square_path(square.box, square)}" class="#{html_classes.join(" ")}"#{tooltip}#{background_color}>
        #{square.number}
      </a>
    }.html_safe
  end

  def link_to_box(box)
    html_classes = ['btn', 'btn-small']
    tooltip = ''
    href = box_squares_path(box)
    text = box.number
    if box.number_of_squares_filled > 0
      html_classes << 'btn-success'
      tooltip = %{ rel="tooltip" data-original-title="#{pluralize(box.squares_left, 'square')} left"}
    end
    %{
      <a href="#{href}" class="#{html_classes.join(" ")}"#{tooltip}>
        #{text}
      </a>
    }.html_safe
  end
end
