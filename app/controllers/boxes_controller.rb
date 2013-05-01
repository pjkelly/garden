class BoxesController < ResourceController
  defaults :resource_class => Box, :collection_name => 'boxes', :instance_name => 'box'
end
