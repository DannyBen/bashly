This fixture tests that flags with arguments also work when the argument
starts with a dash - for example:

```
--options '--verbose -v'
```

Note that when it is expected that flag arguments will be in a form that
resembles a collection of short flags (i.e. single hyphen followed by
alphanumeric characters), for example `--options -abc`, then the compact flags
feature should be disabled with `compact_short_flags: false` in the settings.

See https://bashly.dannyb.co/usage/settings/#compact_short_flags

Reference issues:

- https://github.com/DannyBen/bashly/issues/58
- https://github.com/DannyBen/bashly/issues/499