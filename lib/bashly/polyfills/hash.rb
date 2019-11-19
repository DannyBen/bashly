# :nocov:

# Required for Ruby < 2.4
if !Dir.respond_to? :empty?
  class Dir
    def self.empty?(path_name)
      exist?(path_name) && (entries(path_name) - ['.', '..']).empty?
    end
  end
end