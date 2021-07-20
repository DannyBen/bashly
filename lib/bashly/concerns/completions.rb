require 'completely'

module Bashly
  # This is a `Command` concern responsible for providing bash completion data
  module Completions
    def completion_data(with_version: true)
      result = { full_name => completion_words(with_version: with_version) }
      
      commands.each do |command|
        result.merge! command.completion_data(with_version: false)
      end

      result
    end

    def completion_script
      completion_generator.script
    end

    def completion_function(name = nil)
      completion_generator.wrapper_function(name)
    end

  private

    def completion_generator
      Completely::Completions.new(completion_data)
    end

    def completion_flag_names
      flags.map(&:name) + flags.map(&:short)
    end

    def completion_actions
      completions ? completions.map { |c| "<#{c}>" } : []
    end

    def completion_words(with_version: false)
      trivial_flags = %w[--help -h]
      trivial_flags += %w[--version -v] if with_version
      all = (
        command_names + trivial_flags +
        completion_flag_names + completion_actions
      )

      all.uniq.sort
    end

  end
end
