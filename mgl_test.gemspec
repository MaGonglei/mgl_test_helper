Gem::Specification.new do |s|
  s.name        = 'mgl_test'
  s.version     = '0.0.5'
  s.date        = '2012-09-16'
  s.summary     = "Mgl Test Framework Library"
  s.description = "Mgl test tramework librar,like rake helper,common helper"
  s.authors     = ["Ma Gonglei"]
  s.email       = 'magonglei@gmail.com'
  s.files       = Dir['lib/**/*']
  s.test_files  = Dir['test/**/*']
  s.homepage    = 'https://github.com/MaGonglei'
  s.add_runtime_dependency 'selenium-webdriver','~>2.0'
  s.add_runtime_dependency 'rake'
  s.add_runtime_dependency 'cucumber'
  s.platform = Gem::Platform::RUBY

end