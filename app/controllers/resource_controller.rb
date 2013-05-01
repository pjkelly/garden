class ResourceController < InheritedResources::Base
  include InheritedResources::DSL

  before_filter :authenticate_admin!, :only => [:new, :create, :edit, :update, :destroy]

  helper_method :singular_resource, :plural_resource

  respond_to :html

  def home
    render
  end

  def markdown_preview
    if params[:data]
      @preview = markdown(params[:data])
      render :layout => false
    else
      head :ok
    end
  end

  create! do |success, failure|
    success.html { redirect_to collection_url }
    failure.html { 
      flash[:error] = "There was an error creating this #{singular_resource.downcase}. Please correct below."
      render 'new' 
    }
  end

  update! do |success, failure|
    success.html { redirect_to collection_url }
    failure.html { render 'edit' }
  end

  protected

  def singular_resource
    resource_class.to_s.tableize.humanize.titleize.singularize
  end

  def plural_resource
    resource_class.to_s.tableize.humanize.titleize
  end
end
