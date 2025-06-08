require 'completely'

module Bashly
  # This is a `Command` and `Flag` concern responsible for providing bash
  # completion data
  module Completions
    module Flag
      def completion_data(command_full_name)
        comps = allowed || completions
        return {} unless comps

        aliases.to_h do |name|
          prefix = command_full_name
          prefix = "#{prefix}*" unless prefix.end_with? '*'
          ["#{prefix}#{name}",  comps]
        end
      end
    end

    module Command
      def completion_data(with_version: true)
        result = {}

        completion_full_names.each do |name|
          name = "#{name}*" if name.include? '*'
          result[name] = completion_words with_version: with_version
          flags.each do |flag|
            result.merge! flag.completion_data(name)
          end
        end

        visible_commands.each do |command|
          result.merge! command.completion_data(with_version: false)
        end

        result
      end

      def completion_script
        completion_generator.script
      end

      def completion_function(name = nil)
        completion_generator.wrapper_function name
      end

    protected

      def completion_full_names
        if parent_command
          glue = parent_command.global_flags? ? '*' : ' '
          parent_command.completion_full_names.product(aliases).map { |a| a.join glue }
        else
          aliases
        end
      end

    private

      def completion_generator
        Completely::Completions.new completion_data
      end

      def completion_flag_names
        visible_flags.map(&:name) + visible_flags.map(&:short)
      end

      def completion_allowed_args
        args.map(&:allowed).flatten
      end

      def completion_words(with_version: false)
        trivial_flags = %w[--help -h]
        trivial_flags += %w[--version -v] if with_version
        all = (
          visible_command_aliases + trivial_flags +
          completion_flag_names + completion_allowed_args
        )

        all += completions if completions
        all.compact.uniq.sort
      end
    end
  end
end
