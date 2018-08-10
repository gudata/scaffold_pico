require 'digest/sha2'
version = File.read('VERSION').chomp
built_gem_path = "scaffold_pico-#{version}.gem"
puts "Calc for #{built_gem_path}"
checksum = Digest::SHA512.new.hexdigest(File.read(built_gem_path))
checksum_path = 'checksum/#{built_gem_path}.sha512'
File.open(checksum_path, 'w' ) {|f| f.write(checksum) }
