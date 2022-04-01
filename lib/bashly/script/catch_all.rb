module Bashly
  module Script
    class CatchAll
      class << self
        def option_keys
          @option_keys ||= %i[label help required]
        end

        def from_config(config)
          options = case config
          when nil
            { enabled: false }
          when String
            { label: config }
          when Hash
            { label: config['label'], help: config['help'], required: config['required'] }
          else
            {}
          end

          new **options
        end
      end

      def initialize(label: nil, help: nil, required: false, enabled: true)
        @label, @help, @required, @enabled = label, help, required, enabled
      end

      def enabled?
        @enabled
      end

      def label
        enabled? ? "#{@label&.upcase}..." : nil
      end

      def help
        enabled? ? @help : nil
      end

      def required?
        @required
      end

      def usage_string
        return nil unless enabled?
        required? ? label : "[#{label}]"
      end

    end
  end
end

