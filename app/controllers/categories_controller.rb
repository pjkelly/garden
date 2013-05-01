class CategoriesController < ResourceController
  defaults :resource_class => Category, :collection_name => 'categories', :instance_name => 'category'
end
