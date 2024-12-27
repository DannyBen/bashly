lib = File.expand_path 'lib', __dir__
$LOAD_PATH.unshift lib unless $LOAD_PATH.include? lib
require 'bashly/version'

Gem::Specification.new do |s|
  s.name        = 'bashly'
  s.version     = Bashly::VERSION
  s.summary     = 'Bash Command Line Tool Generator'
  s.description = 'Generate bash command line tools using YAML configuration'
  s.authors     = ['Danny Ben Shitrit']
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*']
  s.executables = ['bashly']
  s.homepage    = 'https://github.com/dannyben/bashly'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 3.1'

  s.add_dependency 'colsole', '>= 0.8.1', '< 2'
  s.add_dependency 'completely', '>= 0.6.1', '< 0.8'
  s.add_dependency 'filewatcher', '~> 2.0'
  s.add_dependency 'gtx', '~> 0.1.1'
  s.add_dependency 'lp', '~> 0.2.0'
  s.add_dependency 'mister_bin', '~> 0.8.1'
  s.add_dependency 'requires', '~> 1.1'
  s.add_dependency 'tty-markdown', '~> 0.7.2'

  # Sub-dependenceis (Ruby 3.3.5 warnings)
  s.add_dependency 'logger', '>= 1', '< 3'    # required by filewatcher
  s.add_dependency 'ostruct', '>= 0', '< 2'   # required by json

  s.metadata = {
    'bug_tracker_uri'       => 'https://github.com/DannyBen/bashly/issues',
    'changelog_uri'         => 'https://github.com/DannyBen/bashly/blob/master/CHANGELOG.md',
    'homepage_uri'          => 'https://bashly.dannyb.co/',
    'source_code_uri'       => 'https://github.com/DannyBen/bashly',
    'rubygems_mfa_required' => 'true',
  }
end
