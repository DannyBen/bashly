# Sanity test for the docker image
describe 'docker image', :docker do
  before(:all) { docker_compose_build }

  describe 'bashly' do
    it 'is installed' do
      expect(docker_compose_run 'bashly-help').to match_approval('docker/bashly-help')
    end
  end

  describe 'pandoc' do
    it 'is installed' do
      expect(docker_compose_run 'pandoc-help').to match_approval('docker/pandoc-help')
    end
  end
end
