class Seed
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :plantings
  belongs_to :category
  belongs_to :sub_category
  belongs_to :seed_source

  field :name, :type => String
  field :catalog_number, :type => Integer

  default_scope order_by(:name.asc)

  validates :name, :presence => true

  before_create :set_catalog_number

  def self.next_catalog_number
    unscoped.order_by(:catalog_number.desc).first.catalog_number + 1
  end

  def set_catalog_number
    self.catalog_number = self.class.next_catalog_number
  end
end
