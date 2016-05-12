require_relative '../scaffold_pico'
require 'choice'

module Scaffold
  class CLI

    def initialize
      Choice.options do
        header 'Synopsys: scaffold_pico.rb  -m user -n Admin -i :roles :company -j :roles :company --fields name:string'
        separator ''
        header 'Specific options:'

        option :debug do
          short '-d'
          long '--debug'
          desc 'print some debug info'
        end

        option :namespace do
          short '-n'
          long '--namespace=namespace1/namespace2'
          validate  /\A(\w+(?:\/\w+)*)\z/
          desc 'Optional namespace for the controllers. Example: -n admin/secret_area'
        end

        option :base_controller do
          short '-b'
          long '--base_controller=AdminController'
          validate  /((::)?([A-Z])+[a-z]*)*\z/
          desc 'Optional base controller. Example: -b Admin::BaseController'
        end

        option :model do
          short '-m'
          long '--model=model'
          desc 'The model. It could be with modules. Example: ModuleA::ModuleB::SomeClassName'
          validate  /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/
        end

        option :includes do
          long '--includes=*INCLUDES'
          desc 'add .includes(*includes) into the collection request, we have join also'
          default []
        end

        option :joins do
          long '--joins=*JOINS'
          desc 'add .joins(*joins) into the collection request, we have includes also'
          default []
        end

        option :fields do
          long '-f'
          long '--fields *FIELDS'
          desc 'title:string body:text published:boolean amount:decimal tracking_id:integer:uniq '
        end

        option :index_fields do
          long '-i'
          long '--index-fields *FIELDS'
          desc 'The fields you wish to see on the index page. Example: --index-fields title body published amount tracking_id'
        end

        option :search_fields do
          long '-s'
          long '--search-fields *FIELDS'
          desc 'Fields on which the search will be done. Example: --search-fields title body published amount tracking_id'
        end


        separator ''
        separator 'Defaults: '

        option :template do
          long '-t'
          long '--template template'
          default 'slim'
          desc 'slim'
        end

        option :css_framework do
          long '-c'
          long '--css_framework css_framework'
          default 'zurb'
          desc 'zurb'
        end

        separator ''
        separator 'Common options: '

        option :help do
          long '--help'
          desc 'Show this message'
        end

      end


    end

    def run
      if Choice[:model]
        scaffold = Scaffold::Main.new(Choice.choices)
        scaffold.run
      else
        puts "try #{$0} --help"
      end
    end
  end
end