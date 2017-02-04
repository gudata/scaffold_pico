class View
  def initialize rails
    @rails = rails
  end

  def folder_name
    @rails.resource.collection_name
  end

end
