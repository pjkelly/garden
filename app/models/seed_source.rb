class SeedSource
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :url, :type => String

  validates :name, :presence => true

  def to_s
    name
  end
end
