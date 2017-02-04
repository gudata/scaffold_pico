class Route
  def initialize rails
    @rails = rails
  end

  # resources :company_ownerships
  def resource_name
    @rails.resource.collection_name
  end

  def nested_in_resources
    @rails.choice[:nested_in_resources]
  end

  def nested?
    nested_in_resources.present?
  end

  def nested_resources_as_array
    (nested_in_resources || "").split('/').collect{|resource| resource.underscore}
  end


end
