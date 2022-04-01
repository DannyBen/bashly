require 'erb'

module Bashly
  module Renderable
    def render(view)
      template = File.read view_path(view)
      erb = ERB.new(template, trim_mode: '%-')
      erb.filename = "#{views_subfolder}.#{view}"
      erb.result binding
    end

    def strings
      @strings ||= MessageStrings.new
    end

    def view_marker(id = nil)
      id ||= ":#{caller_locations.first.path}"
      "# #{id}" unless Bashly.production?
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