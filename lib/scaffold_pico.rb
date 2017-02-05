require 'active_support/inflector'
require 'active_support/core_ext/object/blank'
require 'ostruct'

require 'scaffold/main'
require 'scaffold/rails'
require 'scaffold/erb_context' # I hate this erb

require 'scaffold/models/resource.rb'

require 'scaffold/generators/base_generator'
require 'scaffold/generators/controller_generator'
require 'scaffold/generators/models_generator'
require 'scaffold/generators/views_generator'
require 'scaffold/generators/routes_generator'
require 'scaffold/generators/fabricator_generator'

require 'scaffold/template_engines/slim'
require 'erb'
require 'fileutils'

module Scaffold
  def self.root
    File.dirname __dir__
  end
end