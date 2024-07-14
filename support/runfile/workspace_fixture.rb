require 'yaml'

# A helper class used in Runfile to represent a workspace fixture
class WorkspaceFixture
  class << self
    def dirs
      @dirs ||= Dir['spec/fixtures/workspaces/*'].select { |f| File.directory? f }
    end

    def all
      dirs.map { |dir| WorkspaceFixture.new dir }
    end

    def executables
      all.map(&:executable)
    end
  end

  attr_reader :dir

  def initialize(dir)
    @dir = dir
  end

  def config
    @config ||= if File.exist? yaml_path
      YAML.unsafe_load_file yaml_path
    else
      {}
    end
  end

  def yaml_path
    "#{dir}/src/bashly.yml"
  end

  def executable
    @executable ||= File.file?(executable_path) ? executable_path : nil
  end

  def executable_path
    "#{dir}/#{config['name']}"
  end  
end
