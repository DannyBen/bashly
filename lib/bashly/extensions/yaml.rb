module YAML
  # We trust our loaded YAMLs
  # This patch is due to https://bugs.ruby-lang.org/issues/17866
  # StackOverflow: https://stackoverflow.com/questions/71191685/visit-psych-nodes-alias-unknown-alias-default-psychbadalias/71192990#71192990
  class << self
    alias load unsafe_load
  end
end
