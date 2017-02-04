require 'active_support/inflector'
require 'active_support/core_ext/object/blank'
require 'ostruct'
require 'scaffold/main'
require 'scaffold/rails'
require 'scaffold/erb_context' # I hate this erb
require 'scaffold/base_generator'
require 'scaffold/controller_generator'
require 'scaffold/models_generator'
require 'scaffold/views_generator'
require 'scaffold/routes_generator'
require 'scaffold/fabricator_generator'
require 'scaffold/template_engines/slim'
require 'erb'
require 'fileutils'

module Scaffold
  def self.root
    File.dirname __dir__
  end
end