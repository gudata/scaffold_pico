# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: scaffold_pico 1.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "scaffold_pico".freeze
  s.version = "1.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["gudata".freeze]
  s.date = "2017-08-16"
  s.description = "Scaffolding".freeze
  s.email = "i.bardarov@gmail.com".freeze
  s.executables = ["scaffold_pico".freeze]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "lib/scaffold/cli.rb",
    "lib/scaffold/erb_context.rb",
    "lib/scaffold/generators/base_generator.rb",
    "lib/scaffold/generators/controller_generator.rb",
    "lib/scaffold/generators/fabricator_generator.rb",
    "lib/scaffold/generators/locales_generator.rb",
    "lib/scaffold/generators/models_generator.rb",
    "lib/scaffold/generators/routes_generator.rb",
    "lib/scaffold/generators/views_generator.rb",
    "lib/scaffold/main.rb",
    "lib/scaffold/models/resource.rb",
    "lib/scaffold/rails.rb",
    "lib/scaffold/services/controller.rb",
    "lib/scaffold/services/nested_in_resources.rb",
    "lib/scaffold/services/path.rb",
    "lib/scaffold/services/resource.rb",
    "lib/scaffold/services/route.rb",
    "lib/scaffold/services/view.rb",
    "lib/scaffold/template_engines/slim.rb",
    "lib/scaffold_pico.rb",
    "lib/templates/pico/controller.rb.erb",
    "lib/templates/pico/fabricators/fabrication.rb.erb",
    "lib/templates/pico/locales/bg.scaffold_pico.yml.erb",
    "lib/templates/pico/locales/en.scaffold_pico.yml.erb",
    "lib/templates/pico/model.rb.erb",
    "lib/templates/pico/search.rb.erb",
    "lib/templates/pico/views/materialize/slim/_form.html.slim.erb",
    "lib/templates/pico/views/materialize/slim/edit.html.slim.erb",
    "lib/templates/pico/views/materialize/slim/index.html.slim.erb",
    "lib/templates/pico/views/materialize/slim/new.html.slim.erb",
    "lib/templates/pico/views/materialize/slim/show.html.slim.erb",
    "lib/templates/pico/views/zurb/slim/_form.html.slim.erb",
    "lib/templates/pico/views/zurb/slim/edit.html.slim.erb",
    "lib/templates/pico/views/zurb/slim/index.html.slim.erb",
    "lib/templates/pico/views/zurb/slim/new.html.slim.erb",
    "lib/templates/pico/views/zurb/slim/show.html.slim.erb"
  ]
  s.homepage = "http://github.com/gudata/scaffold_pico".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Scaffold should be simple".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<choice>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<require_all>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>.freeze, [">= 0"])
    else
      s.add_dependency(%q<activesupport>.freeze, [">= 0"])
      s.add_dependency(%q<choice>.freeze, [">= 0"])
      s.add_dependency(%q<require_all>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_dependency(%q<jeweler>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 0"])
    s.add_dependency(%q<choice>.freeze, [">= 0"])
    s.add_dependency(%q<require_all>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
    s.add_dependency(%q<jeweler>.freeze, [">= 0"])
  end
end

