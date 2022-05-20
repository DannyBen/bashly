source "https://rubygems.org"

gem 'byebug'
gem 'lp'
gem 'rspec'
gem 'rspec_approvals'
gem 'runfile'
gem 'runfile-tasks'
gem 'simplecov'

# === REMOVE BEFORE FLIGHT ===
if Dir.exist? '/vagrant/gems/completely'
  gem 'completely', path: '/vagrant/gems/completely'
else
  gem 'completely', git: "https://github.com/dannyben/completely.git"
end
# === REMOVE BEFORE FLIGHT ===

gemspec
