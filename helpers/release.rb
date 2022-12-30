help  'Run release checklist'
usage  'release VERSION'
action :release do |args|
  version = args['VERSION']

  checklist = Checklist.new

  checklist.run "on master branch and nothing to commit" do
    `git status`.match /On branch master.*nothing to commit/m
  end

  checklist.run "code version is #{version}" do
    File.read('lib/bashly/version.rb').include? version
  end

  checklist.run "dockerfile version is #{version}" do
    File.read('Dockerfile').include? version
  end

  checklist.run "tag v#{version} exists" do
    !`git tag -l v#{version}`.empty?
  end

  checklist.run "changelog has a section for #{version}" do
    File.read('CHANGELOG.md').include? "v#{version}"
  end

  checklist.run "github has tag v#{version}" do
    checklist.url_exist? "https://github.com/DannyBen/bashly/tree/v#{version}"
  end

  checklist.run "built gem is version #{version}" do
    `bundle exec bashly --version`.strip == version
  end

  checklist.run "published gem is version #{version}" do
    checklist.url_exist? "https://rubygems.org/gems/bashly/versions/#{version}"
  end

  checklist.run "local docker image exists with tag #{version}" do
    `docker images`.match /bashly\s*#{version}/
  end

  checklist.run "remote docker image exists with tag #{version}" do
    digest = `docker inspect --format='{{.RepoDigests}}' dannyben/bashly:#{version}`[/@sha256:(.*)\]/,1]
    if digest
      checklist.url_exist? "https://hub.docker.com/layers/dannyben/bashly/#{version}/images/sha256-#{digest}"
    else
      false
    end
  end

  checklist.run "github release is available for #{version}" do
    checklist.url_exist? "https://github.com/DannyBen/bashly/releases/tag/v#{version}"
  end

  checklist.run "version in local retype is #{version}" do
    YAML.load_file('/vagrant/sites/bashly/retype.yml')['branding']['label'] == "v#{version}"
  end

  checklist.run "version in remote retype is #{version}" do
    `curl -Ss https://raw.githubusercontent.com/DannyBen/bashly-book/master/retype.yml`.include? "label: v#{version}"
  end

  color = checklist.failed == 0 ? '!bldgrn!' : '!bldred!'
  say "       #{color}Done with #{checklist.failed} failed tasks"
end
