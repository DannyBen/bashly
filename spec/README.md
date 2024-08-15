# Tests

- Testing is done with `rspec`.
- It is recommended to use the [`respec`][2] convenience wrapper for additional
  productivity features.
- The test suite contains interactive approval testing provided by
  [RSpec Approvals][1].

```bash
$ respec
```

## Tagged Specs

Some specs have tags for convenience:

- `:slow` - slow specs that may be skipped when running a smoke test
- `:stable` - specs of features that rarely change
- `:noci` - specs that are disabled in CI

## Useful respec commands


```bash
# smoke test; run only specs that are not :slow and not :stable
$ respec tagged ~stable ~slow

# test examples only
$ respec only examples

# test a specific example only
$ EXAMPLE=whitelist respec only examples

# test only specs that changed recently, and repeat on change
$ respec refactor  # or respec r
```

## Notes about Example Tests

1. Running the tests will regenerate all examples.
2. The generated example executables are .gitignored.
3. Each example contains a `test.sh` file, which calls `bashly generate` 
  (without `bundle exec`) before proceeding with the test. For this reason, you 
  *might* need to install the local gem before running tests, you can do so by
  running `run gem build --install`).


[1]: https://github.com/DannyBen/rspec_approvals
[2]: https://github.com/DannyBen/respec
