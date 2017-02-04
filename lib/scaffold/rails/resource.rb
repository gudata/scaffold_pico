class Resource
  attr :model_name
  attr :modules

  def initialize rails
    @rails = rails
    (@modules, @model_name) = parse_model(@rails.choice[:model])
  end

  # is the resource in modules Reports::Payment
  def modules?
    modules.blank?
  end

  def file_name
    "#{name}.rb"
  end

  # company_ownership
  def name
    model_name.tableize.singularize
  end

  # CompanyOwnership
  def class_name
    model_name.singularize
  end

  # company_ownerships
  def collection_name
    model_name.tableize
  end

  # Search::Manage:BooksSearch
  def search_class_name
    if @rails.controller.namespaced?
      "Search::#{@rails.controller.namespaces_as_modules}::#{class_name.pluralize}Search"
    else
      "Search::#{class_name.pluralize}Search"
    end
  end

  # Admin::User or only User
  def class_name_with_modules
    if modules.empty?
      class_name
    else
      "#{modules.join('::')}::#{class_name}"
    end
  end

  def services_folder
    @rails.choice[:services_folder]
  end


  def fields
    expand_default_types(hasherize_fields(@rails.choice[:fields]))
  end

  private
  def parse_model model
    chunks = model.split('::').select{|chunk| !chunk.empty?}
    class_name = chunks.pop
    [chunks, class_name]
  end

  def expand_default_types hash
    hash.each_pair do |key, value|
      hash[key] = 'string' if value.blank?
    end
  end

  def hasherize_fields fields_array
    fields = {}
    fields_array.each do |field_string|
      (key, value) = field_string.split(':')
      fields[key] = value
    end
    fields
  end

end