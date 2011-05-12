desc "Install all files"
task :install do
  $exclude = [/\.git$/, /\.$/, /\.\.$/, /Rakefile/, /README*/, /\.*\.sw.*/, /.gitkeep/]
  $target_prefix = ENV["HOME"]

  def files(path, prefix="./")
    Dir.foreach(path) do |file|
      next if $exclude.find { |re| file =~ re }

      file = prefix + file

      if File.directory?(file)
        system "mkdir -p #{$target_prefix+"/"+file}"
        files(file, file+"/")
      else
        unless File.exist?($target_prefix+"/"+File.dirname(file))
          system "mkdir -p #{$target_prefix+"/"+File.dirname(file)}"
        end
        puts file
        system "cp #{file} #{$target_prefix+"/"+file}"
      end
    end
  end

  files "."
end
