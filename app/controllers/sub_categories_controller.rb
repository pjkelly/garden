class SubCategoriesController < ResourceController
  belongs_to :category
  defaults :resource_class => SubCategory, :collection_name => 'sub_categories', :instance_name => 'sub_category'
end
