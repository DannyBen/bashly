# Tests

Testing is done with `rspec`.

The test suite contains interactive approval testing provided by
[RSpec Approvals][1].

Run tests with either of these commands:

    $ [bundle exec] run spec
    $ [bundle exec] rspec

## Notes about Example Tests

1. Running the tests will regenerate all examples.
2. The generated example executables are .gitignored.
3. Each example contains a `test.sh` file, which calls `bashly generate` 
  (without `bundle exec`) before proceeding with the test. For this reason, you 
  *might* need to install the local gem before running tests, you can do so by
  running `run gem build --install`).


[1]: https://github.com/DannyBen/rspec_approvals