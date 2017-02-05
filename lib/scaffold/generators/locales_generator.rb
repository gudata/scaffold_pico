module Scaffold
  module Generators
    class LocalesGenerator < Scaffold::Generators::BaseGenerator
      def generate
        return if existing_locale?
        generate_locale('en')
        generate_locale('bg')
      end

      def existing_locale?
        Dir.glob(File.join(locales_path, '**')).each do |name|
          return true if File.basename(name) =~ /scaffold_pico.yml/
        end
        return false
      end

      def generate_locale(locale)
        locales_path = create_locales_path
        source_file_name = "#{locale}.scaffold_pico.yml.erb"
        target_file_name = "#{locale}.scaffold_pico.yml"
        source_file_path = find_root(templates, 'locales', source_file_name)
        content = File.read(source_file_path)

        content = parse_template(content, {rails: @rails})

        target_file_path = File.join(locales_path, target_file_name)

        write_with_confirmation(target_file_path, content)
      end

      def locales_path
        locales_path = File.join(Dir.pwd, 'config', 'locales')
      end

      def create_locales_path
        FileUtils.mkpath(locales_path)
        locales_path
      end

    end
  end
end