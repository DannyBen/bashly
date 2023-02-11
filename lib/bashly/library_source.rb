module Bashly
  class LibrarySource
    attr_reader :uri

    def initialize(uri = nil)
      @uri = uri || File.expand_path('libraries', __dir__)
      transform_github_uri if /^github(:|-)/.match? @uri
    end

    def git?
      /^(git|github|github-ssh):/.match? uri
    end

    def config
      @config ||= YAML.properly_load_file config_path
    end

    def libraries
      config.to_h do |name, spec|
        [name.to_sym, Library.new(path, spec)]
      end
    end

    def config_path
      @config_path ||= if File.exist?("#{path}/libraries.yml")
        "#{path}/libraries.yml"
      else
        raise "Cannot find #{path}/libraries.yml"
      end
    end

    def cleanup
      FileUtils.rm_rf(File.join(Dir.tmpdir, 'bashly-libs-*'))
    end

  private

    def path
      @path ||= if uri.start_with? 'git:'
        git_clone
      else
        uri
      end
    end

    def git_clone
      dir = Dir.mktmpdir 'bashly-libs-'
      safe_run "git clone --depth 1 #{git_specs[:url]} #{dir}"
      safe_run "git checkout #{git_specs[:ref]}" if git_specs[:ref]

      "#{dir}#{git_specs[:path]}"
    end

    def git_specs
      @git_specs ||= begin
        parts = uri.match(%r{git:(?<url>.*\.git)(?:/)?(?<path>/[^@]+)?@?(?<ref>.*)})
        raise 'Invalid source' unless parts

        url = parts[:url]
        raise 'Invalid git URL' unless url

        path = parts[:path]
        ref = parts[:ref].empty? ? nil : parts[:ref]

        { url: url, path: path, ref: ref }
      end
    end

    def safe_run(cmd)
      raise "Failed running command:\nm`#{cmd}`" unless system cmd
    end

    def transform_github_uri
      if (matches = uri.match(%r{github-ssh:(?<user>[^/]+)/(?<repo>[^/]+)(?<rest>.*)}))
        @uri = "git:git@github.com:#{matches[:user]}/#{matches[:repo]}.git#{matches[:rest]}"
      elsif (matches = uri.match(%r{github:(?<user>[^/]+)/(?<repo>[^/]+)(?<rest>.*)}))
        @uri = "git:https://github.com/#{matches[:user]}/#{matches[:repo]}.git#{matches[:rest]}"
      end
    end
  end
end
