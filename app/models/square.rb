class Square
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :box
  has_many :plantings

  field :number, :type => Integer

  default_scope order_by(:number.asc)

  validates :number,
            :presence => true,
            :uniqueness => {
              :scope => :box_id
            }

  def current_planting
    @current_planting ||= plantings.first
  end
end
