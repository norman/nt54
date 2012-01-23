require "rubygems"
require "rake/testtask"

task :default => :test

Rake::TestTask.new do |t|
  t.libs       = ["lib"]
  t.verbose    = false
  t.test_files = FileList['test/*_test.rb']
end

task :clean do
  %x{rm -rf *.gem doc pkg coverage}
  %x{rm -f `find . -name '*.rbc'`}
end

task :gem do
  %x{gem build nt54.gemspec}
end

task :yard => :guide do
  puts %x{bundle exec yard}
end

task :doc => :yard
