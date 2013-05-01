class <%= plural_class_name %>Controller < ResourceController
  defaults :resource_class => <%= class_name %>, :collection_name => '<%= plural_name %>', :instance_name => '<%= singular_name %>'
end
