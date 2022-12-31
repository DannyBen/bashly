help 'Run release checklist'
usage  'release VERSION'
action :release do |args|
  version = args['VERSION']

  checklist = Checklist.new

  say "Checklist for version !txtgrn!#{version}!txtrst!"

  checklist.run 'git on master and clean' do
    `git status`.match(/On branch master.*nothing to commit/m)
  end

  checklist.run 'code version' do
    File.read('lib/bashly/version.rb').include? version
  end

  checklist.run 'dockerfile version' do
    File.read('Dockerfile').include? version
  end

  checklist.run 'local git tag' do
    !`git tag -l v#{version}`.empty?
  end

  checklist.run 'changelog' do
    File.read('CHANGELOG.md').include? "v#{version}"
  end

  checklist.run 'github tag' do
    checklist.url_exist? "https://github.com/DannyBen/bashly/tree/v#{version}"
  end

  checklist.run 'local gem is built' do
    File.exist? "gems/bashly-#{version}.gem"
  end

  checklist.run 'published gem version' do
    checklist.url_exist? "https://rubygems.org/gems/bashly/versions/#{version}"
  end

  checklist.run 'local docker image version' do
    `docker images`.match(/bashly\s*#{version}/)
  end

  checklist.run 'remote docker image version' do
    digest = `docker inspect --format='{{.RepoDigests}}' dannyben/bashly:#{version}`[/@sha256:(.*)\]/, 1]
    if digest
      checklist.url_exist? "https://hub.docker.com/layers/dannyben/bashly/#{version}/images/sha256-#{digest}"
    else
      false
    end
  end

  checklist.run 'github release' do
    `curl -SsI https://github.com/DannyBen/bashly/releases/latest`.match "location: https://github.com/.*/v#{version}"
  end

  checklist.run 'local retype is on master and clean' do
    `git -C /vagrant/sites/bashly status`.match(/On branch master.*nothing to commit/m)
  end

  checklist.run 'local retype version' do
    YAML.load_file('/vagrant/sites/bashly/retype.yml')['branding']['label'] == "v#{version}"
  end

  checklist.run 'remote retype version' do
    `curl -Ss https://raw.githubusercontent.com/DannyBen/bashly-book/master/retype.yml`.include? "label: v#{version}"
  end

  color = checklist.failed.zero? ? '!bldgrn!' : '!bldred!'
  say "       #{color}Done with #{checklist.failed} failed tasks"
end
