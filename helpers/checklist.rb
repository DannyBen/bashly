# A helper class used in Runfile for running through a release checklist
class Checklist
  attr_accessor :failed, :limit

  def initialize(limit: 3)
    @limit = limit
    @failed = 0
  end

  def url_exist?(url)
    `curl -s -o /dev/null -w "%{http_code}" #{url}`.strip.to_i == 200
  end

  def run(text)
    say "!txtblu![....]!txtrst! #{text}  "
    if failed >= limit
      say ''
      return
    end

    ok = yield
    if ok
      resay "!txtgrn![PASS]!txtrst! #{text}"
    else
      resay "!txtred![FAIL]!txtrst! #{text}"
      @failed += 1
    end
  end
end
