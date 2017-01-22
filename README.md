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

    scaffold_pico.rb -m Admin::Vector -n administration -b AdminController \
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

Set some default I18n options

  en.yml:

  scaffold:
    confirm: 'Are you sure?'
    notices:
      success:
        create: Was successfully created %{model}
        update: Was successfully updated %{model}
        destroy: Was successfully destroyed %{model}
      failed:
        create: Fail creating %{model}
        update: Fail updating %{model}
        destroy: Fail destroing %{model}
    new:
      title: "New %{model}"
    show:
      title: "%{model}"
    edit:
      title: "Edit %{model}"
    index:
      title: "%{model}"
      edit: Edit
      show: Show
      destroy: Delete
      actions: Action
      search:
        header: Search
        button: Search
        reset: Reset

    actions:
      index: List %{model}
      actions: 'Actions'
      new: New %{model}
      edit: Edit %{model}
      create: "Create %{model}"
      

# Overriding
If you want to change something you can put it in


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

It would be great if someone wants to make a pull request for erb output

Overwrites the existing files without warnings!

You can't generate scaffolds for a mounted named engines. I don't know if we need this feature.

The Param class has become very messy because of all those variables, so it should be split in small helpers.


## Copyright

Copyright (c) 2016 gudata. See LICENSE.txt for further details.
