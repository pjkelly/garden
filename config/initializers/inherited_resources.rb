# module InheritedResources
#   # Base helpers for InheritedResource work. Some methods here can be overwriten
#   # and you will need to do that to customize your controllers from time to time.
#   #
#   module BaseHelpers
# 
#     protected
# 
#       # This is how the collection is loaded.
#       #
#       # You might want to overwrite this method if you want to add pagination
#       # for example. When you do that, don't forget to cache the result in an
#       # instance_variable:
#       #
#       #   def collection
#       #     @projects ||= end_of_association_chain.paginate(params[:page]).all
#       #   end
#       #
#       def collection
#         get_collection_ivar || set_collection_ivar(end_of_association_chain.all)
#       end
#   end
# end
