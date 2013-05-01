require 'spec_helper'

describe Seed do
  it { should be_mongoid_document }
  it { should be_timestamped_document }
  it { should have_visibility }
  it { should be_sortable }

  it { should have_field(:name).of_type(String) }
  it { should have_field(:catalog_number).of_type(Integer) }
end
