require 'gtx'

module Bashly
  module Renderable
    def render(view)
      GTX.render_file view_path(view), context: binding, filename: "#{views_subfolder}.#{view}"
    end

    def strings
      @strings ||= MessageStrings.new
    end

    def view_marker(id = nil)
      id ||= ":#{caller_locations.first.path}"
      "# #{id}" unless Settings.production?
    end

    # Reads a file from the userspace (Settings.source_dir) and returns
    # its contents. If the file is not found, returns a string with a hint.
    def load_user_file(file, placeholder: true)
      path = "#{Settings.source_dir}/#{file}"

      content = if File.exist? path
        File.read(path).remove_front_matter
      elsif placeholder
        %q[echo "error: cannot load file"]
      else
        ''
      end

      Settings.production? ? content : "#{view_marker path}\n#{content}"
    end

  private

    def view_path(view)
      "#{self_views_path}/#{view}.gtx"
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