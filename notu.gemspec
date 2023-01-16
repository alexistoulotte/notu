Gem::Specification.new do |s|
  s.name = 'notu'
  s.version = File.read("#{File.dirname(__FILE__)}/VERSION").strip
  s.platform = Gem::Platform::RUBY
  s.author = 'Alexis Toulotte'
  s.email = 'al@alweb.org'
  s.homepage = 'https://github.com/alexistoulotte/notu'
  s.summary = 'API for Last.fm'
  s.description = 'API to get Last.fm tracks (top, loved, etc.)'
  s.license = 'MIT'

  s.files = %x(git ls-files | grep -vE '^(spec/|test/|\\.|Gemfile|Rakefile)').split("\n")
  s.executables = %x(git ls-files -- bin/*).split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 3.1.0'

  s.add_dependency 'activesupport', '>= 7.0.0', '< 8.0.0'

  s.add_development_dependency 'byebug', '>= 3.2.0', '< 12.0.0'
  s.add_development_dependency 'rake', '>= 10.3.0', '< 14.0.0'
  s.add_development_dependency 'rspec', '>= 3.1.0', '< 4.0.0'
  s.add_development_dependency 'rubocop', '>= 1.25.0', '< 2.0.0'
  s.add_development_dependency 'rubocop-rake', '>= 0.6.0', '< 1.0.0'
  s.add_development_dependency 'rubocop-rspec', '>= 2.8.0', '< 3.0.0'
  s.add_development_dependency 'vcr', '>= 4.0.0', '< 7.0.0'
  s.add_development_dependency 'webmock', '>= 3.0.0', '< 4.0.0'
end
