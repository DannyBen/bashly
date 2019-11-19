module SpecMixin
  def reset_tmp_dir
    system 'rm -rf spec/tmp/*'
    system 'mkdir -p spec/tmp'
  end
end