Gem::Specification.new do |s|
  s.name = 'notu'
  s.version = File.read("#{File.dirname(__FILE__)}/VERSION").strip
  s.platform = Gem::Platform::RUBY
  s.author = 'Alexis Toulotte'
  s.email = 'al@alweb.org'
  s.homepage = 'https://github.com/alexistoulotte/notu'
  s.summary = 'API for Last.fm'
  s.description = 'API to get Last.fm most played and loved tracks'
  s.license = 'MIT'

  s.rubyforge_project = 'notu'

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'activesupport', '>= 4.1.0', '< 4.2.0'
  s.add_dependency 'nokogiri', '>= 1.6.0', '< 1.7.0'

  s.add_development_dependency 'byebug', '>= 3.2.0', '< 3.3.0'
  s.add_development_dependency 'rake', '>= 10.3.0', '< 10.4.0'
  s.add_development_dependency 'rspec', '>= 3.0.0', '< 3.1.0'
  s.add_development_dependency 'vcr', '>= 2.9.0', '< 2.10.0'
  s.add_development_dependency 'webmock', '>= 1.18.0', '< 1.19.0'
end
