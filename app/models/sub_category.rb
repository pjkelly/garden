class SubCategory
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :category

  field :name, :type => String

  validates :name, :presence => true

  def to_s
    name
  end
end
