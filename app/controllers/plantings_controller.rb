class PlantingsController < ResourceController
  belongs_to :square, :optional => true
  defaults :resource_class => Planting, :collection_name => 'plantings', :instance_name => 'planting'

  def index
    if parent?
      if collection.blank?
        redirect_to new_resource_url
      else
        redirect_to resource_url(collection.first)
      end
    end
  end

  def create
    create! do |success, failure|
      success.html { 
        redirect_to box_square_url(@square.box, @square), :notice => "Succesfully planted #{resource.name} in #{resource.location}"
      }
      failure.html { 
        flash[:error] = "There was an error creating this #{singular_resource.downcase}. Please correct below."
        render 'new' 
      }
    end
  end

  def update
    update! do |success, failure|
      success.html { 
        redirect_to box_square_url(@square.box, @square), :notice => "Succesfully update #{resource.name} in #{resource.location}"
      }
      failure.html { render 'edit' }
    end
  end
end
