class ApplicationController < ActionController::Base
  protect_from_forgery
  layout "application"
  helper :all
  helper_method :markdown, :home?

  protected

  def setup_pagination_parameters
    @page = params[:page] || 1
    @per = params[:per] || 50
  end

  def markdown(text)
    @h ||= Redcarpet::Render::HTML.new(:hard_wrap => true)
    @m ||= Redcarpet::Markdown.new(@h, :autolink => true, :space_after_headers => true)
    @m.render(text).html_safe
  end

  def home?
    controller_name == 'home' && action_name == 'index'
  end
end