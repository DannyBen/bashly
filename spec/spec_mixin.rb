module SpecMixin
  def reset_tmp_dir(create_src: false)
    system 'rm -rf spec/tmp/*'
    system 'mkdir -p spec/tmp'
    system 'mkdir -p spec/tmp/src' if create_src
  end

  def load_fixture(filename)
    @loaded_fixtures ||= {}
    @loaded_fixtures[filename] ||= YAML.load_file("spec/fixtures/#{filename}.yml")
  end
end