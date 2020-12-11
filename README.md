# Scaffolding done right
Soon or later the scaffold from which you start becomes your basic application. I have tried a lot of dynamic administration tooling and soon or later I land on the moment to work and invest time how to make my code work with the admin tool instead of develop my logic.

I beleave that the appication is born and gets old. Starting with great foundation gives you a boost and then the application become mature without the pain.

No learning curve - only what you already know - Ruby on Rails & scaffold

* Support namespaces for the model and the controllers
* You can generate scaffolds for nested resources
* Can override every file per project
* Supports different css frameworks 
   - twitter-boostrap-4.x
   - materializecss 
   - zurb
* Generate fabricators
* Define #index, #edit/new and search during the scafold creation
* You can specify includes/joins for the #index action
* Implement basic search service

# SYNOPSIS

    scaffold_pico \
      -m Admin::Vector -n administration -b AdminController \
      --nested_in_resources Assets::VectorFrame \
      --fields name: description:text featured:boolean license:belongs_to group_id:integer svg:file \
      --index-fields id name imported featured \
      --search-fields name aspect_ratio license created_at \
      --fabrication \
      --services_folder=services \
      --debug --css_framework=materialize \
      --custom_inflection vector vectors


![alt tag](https://raw.githubusercontent.com/gudata/scaffold_pico/master/doc/screenshot_index.jpg)



# Install

This project assumes that you use simple_form and kaminari, but if you have other preferences you can change them.

You should already have in your Gemfile something like

    gem 'kaminari'
    gem 'slim-rails'
    gem 'simple_form'

    # And one of those
    #
    # gem 'materialize-sass'
    # gem 'foundation-rails'

There is no need to have it in your gem file.

    gem install scaffold_pico

Scaffold Pico is cryptographically signed. To be sure the gem you install hasn’t been tampered with:

Add my public key (if you haven’t already) as a trusted certificate

gem cert --add <(curl -Ls https://raw.githubusercontent.com/gudata/scaffold_pico/master/certs/gudata.pem)

gem install scaffold_pico -P MediumSecurity

The MediumSecurity trust profile will verify signed gems, but allow the installation of unsigned dependencies.

This is necessary in case not all of Scaffold Pico’s dependencies are signed, so we cannot use HighSecurity.




# Overriding
If you want to change something you can override/change

    RAILS_ROOT/config/locales/en.scaffold_pico.yml
    RAILS_ROOT/lib/templates/pico/
                                /controller.rb
                                /search.rb
                                /fabricators
                                  fabrication.rb.erb
                                /views/{materialize|zurb} <<< Note !
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


## License MIT

Copyright (c) 2017 gudata. See LICENSE.txt for further details.

[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fgudata%2Fscaffold_pico.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fgudata%2Fscaffold_pico?ref=badge_shield)

