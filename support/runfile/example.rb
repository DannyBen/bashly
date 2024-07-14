require 'yaml'

# A helper class used in Runfile to generate example README files
class Example
  class << self
    def examples
      filter_dirs('examples').map { |dir| new dir }
    end

    def fixtures      
      filter_dirs('spec/fixtures/workspaces').map { |dir| new dir, type: :fixture }
    end

    def all
      examples + fixtures
    end

  private

    def filter_dirs(base_dir)
      Dir["#{base_dir}/*"].select { |f| File.directory? f }
    end

  end

  attr_reader :dir, :type

  def initialize(dir, type: :example)
    @dir = dir
    @type = type
  end

  def inspect
    %Q[#<Example type=:#{type}, dir="#{dir}">]
  end

  def config
    @config ||= if File.exist? yaml_path
      YAML.unsafe_load_file yaml_path
    else
      {}
    end
  end

  def yaml
    @yaml ||= File.read(yaml_path).strip
  end

  def yaml_path
    "#{dir}/src/bashly.yml"
  end

  def readme
    @readme ||= File.exist?(readme_path) ? File.read(readme_path) : ''
  end

  def readme_path
    "#{dir}/README.md"
  end

  def regenerate_readme
    raise "#regenerate_readme called on a fixture" if type == :fixture
    File.write readme_path, generated_readme
  end

  def executable
    @executable ||= File.file?(executable_path) ? executable_path : nil
  end

private

  def executable_path
    "#{dir}/#{config['name']}"
  end

  def test_commands
    filename = "#{dir}/test.sh"
    content = File.read filename
    marker = '### Try Me ###'
    return nil unless content.include? marker

    result = content
      .split(/\s*#{marker}\s*/).last
      .split("\n")
      .reject { |line| line.empty? or line.start_with? '#' }
    abort "Can't find #{marker} marker in #{filename}" if result.empty?
    result
  end

  def test_output
    return nil unless test_commands

    result = ''
    test_commands.each do |command|
      result += "### `$ #{command}`\n\n"
      result += "````shell\n"
      Dir.chdir dir do
        result += `#{command} 2>&1`
        result += "\n\n"
      end
      result += "````\n\n"
    end
    result
  end

  def generated_readme
    marker = '-----'
    content = readme.split(marker)[0].strip
    extra_files = ''
    if content =~ /<!-- include: (.*) -->/
      included_files = $1.split
      extra_files = files_markdown included_files
    end

    <<~MARKDOWN
      #{content}

      #{marker}

      ## `bashly.yml`

      ````yaml
      #{yaml}
      ````

      #{extra_files}

      ## Output

      #{test_output || '*None*'}

    MARKDOWN
  end

  def files_markdown(files)
    result = []
    files.each do |file|
      lang = markdown_lang file
      result << "## `#{file}`\n"
      result << "````#{lang}"
      result << File.read("#{dir}/#{file}")
      result << "````\n"
    end

    result.join "\n"
  end

  def markdown_lang(file)
    result = langs[File.extname file]
    raise "Cannot determine language for #{file}" unless result

    result
  end

  def langs
    @langs ||= {
      ''      => 'bash',
      '.md'   => 'markdown',
      '.sh'   => 'bash',
      '.ini'  => 'ini',
      '.yml'  => 'yaml',
      '.yaml' => 'yaml',
    }
  end
end
