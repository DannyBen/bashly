module SpecMixin
  def reset_tmp_dir(create_src: false)
    system 'rm -rf spec/tmp/*'
    system 'mkdir -p spec/tmp'
    system 'mkdir -p spec/tmp/src' if create_src
  end
end