desc 'Run turnip feature tests'
RSpec::Core::RakeTask.new(:turnip) do |t|
  t.pattern = './spec{,/*/**}/*.feature'
  t.rspec_opts = ['-r turnip/rspec']
end
