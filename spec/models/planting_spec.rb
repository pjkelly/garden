require 'spec_helper'

describe Planting do
  it { should be_mongoid_document }
  it { should be_timestamped_document }
  it { should have_visibility }
  it { should be_sortable }

  it { should have_field(:planted_on).of_type(Date) }
  it { should have_field(:configuration).of_type(String) }
  it { should have_field(:initial_harvest_on).of_type(Date) }
  it { should have_field(:completed_on).of_type(Date) }
  it { should have_field(:notes).of_type(String) }
end
