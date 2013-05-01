class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :sub_categories

  field :name, :type => String
  field :color, :type => String, :default => '#ffffff'

  validates :name, :color, :presence => true

  def to_s
    name
  end
end
