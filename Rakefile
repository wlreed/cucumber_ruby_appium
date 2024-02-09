desc 'delete symbolic link'
file :delete_link do
  FileUtils.rm_rf('./appium.txt')
end

desc 'symbolically link appium config file'
task :link_file, [:os] do |_t, args|
  if args[:os].downcase == 'ios'
    puts "linking ios file #{args[:os]}"
  elsif args[:os].downcase == 'android'
    puts "linking android file #{args[:os]}"
  else
    raise IOError, "Don't have a file for #{args[:os]}"
  end
end

desc 'run tests with :os and :tags options'
task :test, [:os, :tags] do |_t, args|
  puts "args: #{args}"
  puts "args: #{args[:os]}"
  puts "args: #{args[:tags]}"
end

task :my_task, [:arg1, :arg2] do |_t, args|
  puts "Args were: #{args} of class #{args.class}"
  puts "arg1 was: '#{args[:arg1]}' of class #{args[:arg1].class}"
  puts "arg2 was: '#{args[:arg2]}' of class #{args[:arg2].class}"
end
