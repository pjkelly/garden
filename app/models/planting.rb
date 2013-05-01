class Planting
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :square
  belongs_to :seed

  CONFIGURATIONS = %w(1 2 2x2 3x3 4x4 scatter)

  field :planted_on, :type => Date
  field :transplant, :type => String
  field :configuration, :type => String
  field :initial_harvest_on, :type => Date
  field :completed_on, :type => Date
  field :notes, :type => String

  default_scope order_by(:planted_on.desc)

  validates :configuration,
            :inclusion => {
              :in => CONFIGURATIONS,
              :allow_blank => true
            }

  def name
    if transplant.present?
      transplant
    else
      seed.name
    end
  end

  def location
    [square.box.number, square.number].join('-')
  end

  def transplant?
    transplant.present?
  end
end
