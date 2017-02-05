# scaffold_pico
## Scaffolding done right
With this gem you can create your own pretty administration with a seconds.

No learning curve.

No need to learn DSLs or support 3rd party gems.


* Support namespaces for the model and the controllers
* Generate fabricators
* Supports different css frameworks - zurb / materializecss
* Can specify different fields for #index, #edit/new and search
* Can override every file per project
* You can specify includes/joins for the #index action
* Includes search

![alt tag](https://raw.githubusercontent.com/gudata/scaffold_pico/master/doc/screenshot_index.jpg)


# SYNOPSIS

    scaffold_pico.rb \
      -m Admin::Vector -n administration -b AdminController \
      --nested_in_resources Assets::VectorFrame \
      --fields name: description:text featured:boolean license:belongs_to group_id:integer svg:file \
      --index-fields id name imported featured \
      --search-fields name aspect_ratio license created_at \
      --fabrication \
      --services_folder=services \
      --debug --css_framework=materialize


# Install
The gem assume you have already in your Gemfile

    gem 'kaminari'
    gem 'slim-rails'
    gem 'simple_form'

    # And one of those
    #
    # gem 'materialize-sass'
    # gem 'foundation-rails'

There is no need to have it in your gem file.

    gem install scaffold_pico

# Overriding
If you want to change something you can override/change

    RAILS_ROOT/config/locales/en.scaffold_pico.yml
    RAILS_ROOT/lib/templates/pico
                                /controller.rb
                                /search.rb
                                /fabricators
                                  fabrication.rb.erb
                                /views
                                  /materialize
                                    _form.html.slim.erb
                                    edit.html.slim.erb
                                    index.html.slim.erb
                                    new.html.slim.erb
                                    show.html.slim.erb
                                  /zurb
                                    _form.html.slim.erb
                                    edit.html.slim.erb
                                    index.html.slim.erb
                                    new.html.slim.erb
                                    show.html.slim.erb

# Develop

Clone the repo in ~/scaffold_pico or whatever, then in some rails project run the binary like this

    export SCAFFOLD_PICO_HOME=~/scaffold_pico
    ruby -I $SCAFFOLD_PICO_HOME/lib $SCAFFOLD_PICO_HOME/bin/scaffold_pico \
      --css_framework=materialize \
      --template=slim \
      -m User -n Admin -b AdminController \
      --fields name:string

# Known Issues
If you can't start scaffold_pico you might need to update your bundler

    gem update bundler

Help please: For some of the generated models/views there are extra blank links. It would be great if someone knows how to parse the erb and skip the new lines

You can't generate scaffolds for a mounted named engines. I don't know if we need this feature.


## Copyright

Copyright (c) 2017 gudata. See LICENSE.txt for further details.
