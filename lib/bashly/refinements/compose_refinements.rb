require 'yaml'

module ComposeRefinements
  refine Hash do
    def compose(keyword = 'import')
      result = {}
      each do |k, v|
        if k.to_s == keyword
          sub = YAML.load_file(v).compose keyword
          if sub.is_a? Array
            result = sub
          else
            result.merge! sub
          end
        elsif v.respond_to? :compose
          result[k] = v.compose keyword
        else
          result[k] = v
        end
      end
      result
    end
  end

  refine Array do
    def compose(keyword = 'import')
      map do |x|
        if x.respond_to? :compose
          x.compose keyword
        else
          x
        end
      end
    end
  end
end
