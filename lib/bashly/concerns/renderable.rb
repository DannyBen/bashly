require 'erb'

module Bashly
  module Renderable
    def render(view)
      template = File.read view_path(view)
      # TODO: This new format is only supported in Ruby >= 2.6
      #       So for now, we keep the old deprecated syntax
      # ERB.new(template, trim_mode: '%-').result(binding)
      ERB.new(template, nil, '%-')
    end

    def strings
      @strings ||= MessageStrings.new
    end

  private

    def view_path(view)
      "#{self_views_path}/#{view}.erb"
    end

    def self_views_path
      @self_view_path ||= "#{base_views_path}/#{views_subfolder}"
    end

    def base_views_path
      @base_views_path ||= File.expand_path("../views/", __dir__)
    end

    def views_subfolder
      @views_subfolder ||= self.class.name.split('::').last.to_underscore
    end
  end
end