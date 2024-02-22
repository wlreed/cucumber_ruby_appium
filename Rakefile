require 'cucumber'
require 'cucumber/rake/task'

def rm_symlink
  File.delete('appium.txt')
end

def add_symlink(os)
  puts "creating symlink for #{os}"
  sym = 'appium.txt'
  dir = 'appium_configs'
  fn = File.join(dir, "appium_#{os}.txt")
  File.symlink(fn, sym)
end

desc 'delete symbolic link'
file :rm_symlink do
  rm_symlink
end

desc 'symbolically link appium config file'
task :add_symlink, [:os] do |_t, args|
  rm_symlink
  if args[:os].downcase == 'ios'
    puts "linking ios file #{args[:os]}"
    add_symlink('ios')
  elsif args[:os].downcase == 'android'
    puts "linking android file #{args[:os]}"
    add_symlink('android')
  else
    raise IOError, "Don't have a file for #{args[:os]}"
  end
end

desc 'run tests with :os and :tags options'
task :test, [:os, :tags] do |_t, args|
  puts "args: #{args}"
  puts "args: #{args[:os]}"
  Rake::Task[:add_symlink].invoke(args[:os])
  puts "args: #{args[:tags]}"
  if args[:tags]
    Rake::Task['cucumber'].invoke("--tags #{args[:tags]}")
  else
    Rake::Task['cucumber'].execute
  end
end

# to call this task with parameters, make a call like:  'rake cucumber["<parameter>"]'
# example: 'rake cucumber["--tags @activate"]'
desc 'Run cucumber with desired [:cmd] parameters'
task :cucumber, [:cmd] do |_task, args|
  Cucumber::Rake::Task.new do |x|
    x.profile = :default
    x.cucumber_opts = args.cmd.to_s
  end
end

task :my_task, [:arg1, :arg2] do |_t, args|
  puts "Args were: #{args} of class #{args.class}"
  puts "arg1 was: '#{args[:arg1]}' of class #{args[:arg1].class}"
  puts "arg2 was: '#{args[:arg2]}' of class #{args[:arg2].class}"
end
