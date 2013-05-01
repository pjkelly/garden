require 'spec_helper'

describe <%= class_name %> do
  it { should be_mongoid_document }
  it { should be_timestamped_document }
  it { should have_visibility }
  it { should be_sortable }

<%- @model_attributes.each do |attribute| -%>
  it { should have_field(:<%= attribute.name %>).of_type(<%= attribute.type.to_s.classify %>) }
<%- end -%>
end
