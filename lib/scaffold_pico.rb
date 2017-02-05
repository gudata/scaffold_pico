require 'active_support/inflector'
require 'active_support/core_ext/object/blank'
require 'ostruct'

require 'scaffold/rails'
require 'scaffold/main'
require 'scaffold/erb_context' # I hate this erb

require 'scaffold/models/resource.rb'

require 'scaffold/template_engines/slim'
require 'erb'
require 'fileutils'

module Scaffold
  def self.root
    File.dirname __dir__
  end
end