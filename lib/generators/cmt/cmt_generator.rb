require 'rails/generators/generated_attribute'

class CmtGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  argument :model_name, :type => :string, :required => true, :banner => 'ModelName'
  argument :model_attrs, :type => :array, :default => [], :banner => 'model:attributes'
  argument :namespace, :type => :string, :default => "admin"

  class_option :skip_model, :desc => 'Don\'t generate a model or migration file.', :type => :boolean
  class_option :skip_controller, :desc => 'Don\'t generate controller, helper, or views.', :type => :boolean

  def initialize(*args, &block)
    super

    @model_attributes = []
    @skip_model = options.skip_model?

    model_attrs.each do |arg|
      @model_attributes << Rails::Generators::GeneratedAttribute.new(*arg.split(':'))
    end

    @model_attributes.uniq!

    if @model_attributes.empty?
      @skip_model = true # skip model if no attributes
    end
  end

  def create_model
    unless @skip_model
      template 'model.rb', "app/models/#{singular_name}.rb"
      template "spec/model.rb", "spec/models/#{singular_name}_spec.rb"
    end
  end

  def create_controller
    unless options.skip_controller?
      template 'controller.rb', "app/controllers/#{plural_name}_controller.rb"

      %w[index new edit _form show].each do |t|
        template "views/#{t}.html.erb", "app/views/#{plural_name}/#{t}.html.erb"
      end

      inject_into_file "config/routes.rb", "  resources #{plural_name.to_sym.inspect}\n", :after => "Application.routes.draw do\n"
      inject_into_file 'app/views/layouts/application.html.erb', %{      <%= nav_link_to "#{plural_resource}", #{plural_name}_path, '#{plural_name}' %>\n}, :after => "<ul class=\"nav\">\n"
    end
  end

  private

  def singular_name
    model_name.underscore
  end

  def plural_name
    model_name.underscore.pluralize
  end

  def class_name
    model_name.camelize
  end

  def plural_class_name
    plural_name.camelize
  end

  def singular_resource
    plural_name.humanize.titleize.singularize
  end

  def plural_resource
    plural_name.humanize.titleize
  end

  def controller_namespace
    namespace.blank? ? '' : namespace.classify + '::'
  end

  def namespace_for_url_helper
    namespace.blank? ? '' : namespace + '_'
  end

  def inherit_from_controller
    namespace.blank? ? 'Application' : controller_namespace.gsub('::', '')
  end

  def model_columns_for_attributes
    class_name.constantize.columns.reject do |column|
      column.name.to_s =~ /^(id|created_at|updated_at)$/
    end
  end

  def model_exists?
    File.exist? destination_path("app/models/#{singular_name}.rb")
  end

  def destination_path(path)
    File.join(destination_root, path)
  end
end
