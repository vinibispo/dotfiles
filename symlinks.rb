# frozen_string_literal: true

directories = Dir
              .glob('*')
              .map { |f| File.expand_path(f) }
              .reject { |f| File.file?(f) }

directories.each do |dir|
  puts dir
  location_of_folder =
    if File.exist?("#{dir}/.location")
      File.read("#{dir}/.location").gsub("\n", '')
    else
      '~'
    end
  folder = File.expand_path(location_of_folder)
  if File.exist?(folder)
    if File.symlink?(folder)
      File.unlink(folder)
      File.symlink(dir, folder)
    else
      children_dir = Dir.children(dir)
      children_dir.each do |file|
        complete_path = "#{folder}/#{file}"
        file_expanded = File.expand_path("#{dir}/#{file}")
        File.unlink(complete_path) if File.symlink?(complete_path)
        File.symlink(file_expanded, complete_path)
      end
    end
  else
    File.symlink(dir, folder)
  end
end
