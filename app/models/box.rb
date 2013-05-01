class Box
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :squares

  field :number, :type => Integer
  field :notes, :type => String

  default_scope order_by(:number.asc)

  validates :number,
            :presence => true,
            :uniqueness => true

  def number_of_squares_filled
    squares.reject { |s| s.plantings.blank? }.length
  end

  def squares_left
    16 - number_of_squares_filled
  end
end
