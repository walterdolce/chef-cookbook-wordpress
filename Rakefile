task :unit do
  sh 'rspec'
end

task :acceptance do
  sh 'kitchen test'
end

desc 'Run all tests'
task :test => [:unit, :acceptance]

task :default => [:test]
