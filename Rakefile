def travis?
  ENV['TRAVIS'] == 'true'
end

desc 'Run Test Kitchen integration tests'
namespace :integration do

  desc 'Run integration tests with kitchen-docker'
  task :docker do
    require 'kitchen'
    Kitchen.logger = Kitchen.default_file_logger
    @loader = Kitchen::Loader::YAML.new(local_config: '.kitchen.docker.yml')
    Kitchen::Config.new(loader: @loader).instances.each do |instance|
      instance.test(:always)
    end
  end

  desc 'Run all tests'
  task :test => [:unit, :acceptance]

  desc 'Run unit tests'
  task :unit do
    sh 'rspec'
  end

  desc 'Run integration tests with default kitchen provider'
  task :acceptance do
    sh 'kitchen test'
  end

  task :default => [:test]
end


desc 'Run Test Kitchen integration tests'
task integration: travis? ? %w(integration:docker) : %w(integration:default)

