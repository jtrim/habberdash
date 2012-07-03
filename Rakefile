#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

APP_RAKEFILE = File.expand_path('../spec/dummy/Rakefile', __FILE__)
load 'rails/tasks/engine.rake'
Bundler::GemHelper.install_tasks

require 'cucumber/rake/task'
require 'evergreen/tasks'

Cucumber::Rake::Task.new(:cucumber) do |t|
  # t.cucumber_opts = "features --format pretty"
end

namespace :spec do

  desc 'Prepare the rails app DB for tests'
  task :prepare do
    `cd spec/dummy && rake db:test:load`
  end

end

namespace(:app) { task :spec => 'spec:prepare' }

task :default => ['app:spec', 'spec:javascripts', :cucumber]
