class SeedsController < ResourceController
  defaults :resource_class => Seed, :collection_name => 'seeds', :instance_name => 'seed'
end
