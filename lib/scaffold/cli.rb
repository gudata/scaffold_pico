require 'scaffold_pico'
require 'choice'

module Scaffold
  class CLI

    def initialize
      Choice.options do
        header 'Synopsys: scaffold_pico.rb  -m user -n Admin -i :roles :company -j :roles :company --fields name:string'
        separator ''
        header 'Specific options:'

        option :namespace do
          short '-n'
          long '--namespace=Namespace'
          desc 'Optional namespace: ModuleA::ModuleB'
          validate  /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/
        end

        option :model do
          short '-m'
          long '--model=model'
          desc 'The model'
        end

        option :includes do
          short '-i'
          long '--includes=*INCLUDES'
          desc 'add .includes(*includes) into the collection request, we have join also'
          default []
        end

        option :joins do
          short '-j'
          long '--joins=*JOINS'
          desc 'add .joins(*joins) into the collection request, we have includes also'
          default []
        end

        option :fields do
          long '-f'
          long '--fields *FIELDS'
          desc 'title:string body:text published:boolean amount:decimal tracking_id:integer:uniq '
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
        scaffold = Scaffold::Pico.new(Choice.choices)
        scaffold.run
      else
        puts "try #{$0} --help"
      end
    end
  end
end