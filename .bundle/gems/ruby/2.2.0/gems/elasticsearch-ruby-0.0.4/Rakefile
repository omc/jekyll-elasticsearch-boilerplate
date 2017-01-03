require 'bundler/gem_tasks'

require 'rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.libs << 'lib' << 'spec'
end

task :default => :test
