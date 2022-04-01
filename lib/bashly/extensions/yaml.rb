module YAML
  # This awkward patch is due to https://bugs.ruby-lang.org/issues/17866
  def self.properly_load_file(path)
    YAML.load_file path, aliases: true
  rescue ArgumentError
    # :nocov:
    YAML.load_file path
    # :nocov:
  end
end
