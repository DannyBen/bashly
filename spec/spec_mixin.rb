module SpecMixin
  def reset_tmp_dir(create_src: false, example: nil)
    system 'rm -rf spec/tmp/*'
    system 'mkdir -p spec/tmp'
    system 'mkdir -p spec/tmp/src' if create_src
    cp "examples/#{example}/*" if example
  end

  def load_fixture(filename)
    @loaded_fixtures ||= {}
    @loaded_fixtures[filename] ||= YAML.properly_load_file("spec/fixtures/#{filename}.yml")
  end

  def cp(source, target = 'spec/tmp/')
    expect(system "cp -r #{source} #{target}").to be true
  end
end