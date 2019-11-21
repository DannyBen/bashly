require 'mister_bin'
require 'fileutils'

module Bashly
  module Commands
    class Base < MisterBin::Command
      include AssetHelper
    end
  end
end
