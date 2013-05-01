class SquaresController < ResourceController
  belongs_to :box
  defaults :resource_class => Square, :collection_name => 'squares', :instance_name => 'square'

  def show
    if resource.plantings.blank?
      redirect_to new_square_planting_url(resource) and return
    else
      @planting = resource.plantings.first
    end

    super
  end
end
