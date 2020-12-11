require_relative '../scaffold_pico'
require 'choice'

module Scaffold
  class CLI

    def initialize
      Choice.options do
        header 'Synopsys: scaffold_pico.rb -m User -n Admin --includes :roles :company --joins :roles :company --fields name:string --fabrication'
        separator ''
        header 'Specific options:'

        option :debug do
          short '-d'
          long '--debug'
          desc 'print some debug info'
        end

        option :force do
          long '--force'
          desc 'Overwrite without asking questions'
        end

        option :fabrication do
          long '--fabrication'
          desc 'Generate fabrication fabricator https://github.com/paulelliott/fabrication'
        end

        option :controller_namespaces do
          short '-n'
          long '--controller_namespaces=namespace1/namespace2'
          validate  /\A(\w+(?:\/\w+)*)\z/
          desc 'Optional namespaces for the controllers. Example: -n admin/secret_area. '
        end

        option :nested_in_resources do
          short '-nr'
          long '--nested_in_resources=Reports::Client/Building'
          validate  /\A(?:::)?(?:(?:[A-Z]\w*(?:::[A-Z]\w*)*)\/?)*\z/
          desc 'Optional nest resource in other resources. Example: -nr Reports::Client/Building -m Room'
        end

        option :base_controller do
          short '-b'
          long '--base_controller=AdminController'
          validate  /((::)?([A-Z])+[a-z]*)*\z/
          desc 'Optional base controller. Example: -b Admin::BaseController'
        end

        option :model, :required => true do
          short '-m'
          long '--model=SuperAdmin::User'
          desc 'The model. It could be with modules. Example: ModuleA::ModuleB::SomeClassName'
          validate  /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/
        end

        option :no_model do
          long '--no-model'
          desc 'Do not generate file. It can help when you need to recreate the views on a model which already exists and have some code'
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
          desc 'title:string library:belongs_to body:text published:boolean amount:decimal attachment:file tracking_id:integer:uniq '
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

        option :custom_inflection do
          long '--custom_inflection *FIELDS'
          desc 'Custom singular and plural form. Example: --custom_inflection campus campuses'
        end

        separator ''
        separator 'Defaults: '

        option :template do
          long '-t'
          long '--template template'
          validate  /\A(slim)\z/
          default 'slim'
          desc 'slim'
        end

        option :css_framework do
          long '-c'
          long '--css_framework zurb'
          default 'twitter_bootstrap_4x'
          validate  /\A(zurb|materialize|twitter_bootstrap_4x)\z/
          desc 'zurb, materialize, twitter_bootstrap_4x'
        end

        option :services_folder do
          long '--services_folder=services'
          validate  /\A(\w+(?:\/\w+)*)\z/
          default 'services'
          desc 'Where to put the search model. Example: --services=actions'
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
        add_custom_inflection(Choice.choices[:custom_inflection]) if Choice.choices[:custom_inflection]
        scaffold = Scaffold::Main.new(Choice.choices)
        scaffold.run
      else
        puts "try #{$0} --help"
      end
    end

    private

    def add_custom_inflection(inflection)
      ActiveSupport::Inflector.inflections do |inflect|
        inflect.irregular inflection.first, inflection.last
      end
    end
  end
end
