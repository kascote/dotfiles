# taked from Ryan Bates 
# git://github.com/ryanb/dotfiles.git
#
require 'rake'

namespace :install do 
  desc "install the dot files into user's home directory"
  task :dot do
    replace_all = false
    Dir['dot/*'].each do |file|
      file = File.basename(file)
      next if %w[Rakefile README LICENSE].include? file
      
      if File.exist?(File.join(ENV['HOME'], ".#{file}"))
        if replace_all
          replace_file(file)
        else
          print "overwrite ~/.#{file}? [ynaq] "
          case $stdin.gets.chomp
          when 'a'
            replace_all = true
            replace_file(file)
          when 'y'
            replace_file(file)
          when 'q'
            exit
          else
            puts "skipping ~/.#{file}"
          end
        end
      else
        link_file(file)
      end
    end
  end

  desc "install bin files"
  task :bin do
    system %Q{ln -s "$PWD/bin" "$HOME/bin"}
  end

end

def replace_file(file)
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/dot/#{file}" "$HOME/.#{file}"}
end

