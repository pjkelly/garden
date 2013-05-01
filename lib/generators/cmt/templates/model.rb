class <%= class_name %>
  include Mongoid::Document
  include Mongoid::Timestamps

<%- @model_attributes.each do |attribute| -%>
  field :<%= attribute.name %>, :type => <%= attribute.type.to_s.classify %>
<%- end -%>

  def to_s
    _id.to_s
  end
end
