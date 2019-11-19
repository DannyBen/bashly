module Bashly
  class Interrupt < Interrupt; end
  class Error < StandardError; end
  class InitError < Error; end
  class ConfigurationError < Error; end
end