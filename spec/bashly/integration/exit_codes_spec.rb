require 'spec_helper'

describe 'exit codes' do
  let(:path) { "spec/fixtures/workspaces/#{workspace}" }
  let(:workspace) { "exit-codes" }
  
  def test(args, approval, exit_code, env_var = true)
    Dir.chdir path do
      ENV['API_KEY'] = env_var ? 'set' : nil
      expect(`./cli #{args}`).to match_approval("exit/#{approval}")
      expect($?.exitstatus).to eq exit_code
    end
  end

  describe 'required environment variable' do
    it("exits with 1") { test '', 'env-var', 1, false }
  end

  describe 'usage' do
    it("exits with 1") { test '', 'usage', 1 }
  end

  describe '--help' do
    it("exits with 0") { test '--help', 'help', 0 }
  end

  describe 'missing argument' do
    it("exits with 1") { test 'download', 'arg', 1 }
  end

  describe 'missing flag' do
    it("exits with 1") { test 'login', 'flag', 1 }
  end

end
