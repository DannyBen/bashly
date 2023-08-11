Change Log
========================================

v1.0.8 - 2023-08-11
----------------------------------------

- Add ini library for handling INI files with sections
- Config Library: Add ability to set default value in `config_get`
- Config Library: Refactor to allow sections and use the low level INI library
- Gemspec: Add Psych dependency


v1.0.7 - 2023-07-07
----------------------------------------

- Add suport for auto-organizing command files in subfolders
- Pre-process config files using ERB


v1.0.6 - 2023-06-27
----------------------------------------

- Add completions for bashly itself
- Add `bashly completions --install` command
- Upgrade completely version to 0.6.0
- Add `bashly completions --uininstall` command
- Upgrade completely version to 0.6.1
- Remove colors from `bashly shell` prompt


v1.0.5 - 2023-06-02
----------------------------------------

- Add bashly interactive shell


v1.0.4 - 2023-05-02
----------------------------------------

- Allow using `bashly-settings.yml` instead of `settings.yml`
- Fix completions library to not show private commands
- Fix completions library to not show private flags


v1.0.3 - 2023-04-08
----------------------------------------

- Move 'initialize.sh' to 'bashly add hooks'
- Drop support for ruby 2.7
- Add validation alert when 'allowed' is provided without either a 'default' or 'required'
- Update validation errors to highlight words that are YAML options
- Fix arg.allowed and flag.allowed to allow setting without 'required' or 'default'
- Fix 'default' and 'required' for flags with a short name only


v1.0.2 - 2023-03-23
----------------------------------------

- Do not add dependencies-filter view marker when there are no dependencies
- Fix initialize.bash not being injected
- Add before/after hooks
- Add 'bashly add hooks' command
- Add hooks example


v1.0.1 - 2023-03-03
----------------------------------------

- Allow dot in command.name
- Change settings.strict to allow any string
- Update dependencies option to support 'any' (e.g. wget or curl)
- Add a 'deps' associative array to the generated bash script


v1.0.0 - 2023-02-16
----------------------------------------

- Show --help and --version last in Options list
- Fix environment variables caption to not show if all are private
- Remove env var validation rule for private + default
- Add support for private flags
- Allow configuring the path to bashly.yml
- Allow customizing the path to settings.yml
- Remove environment variables from all --help messages
- Refactor libraries
- Refactor 'bashly add libraries' command
- Add support for adding libraries from a custom directory
- Add support for git-sourced libraries
- Add auto upgrade support to custom library sources
- Remove deprecated command.short
- Add command.name validation


v0.9.5 - 2023-01-31
----------------------------------------

- Upgrade dependencies


v0.9.4 - 2022-12-31
----------------------------------------

- Fix validate --verbose command
- Add support for color usage elements


v0.9.3 - 2022-12-24
----------------------------------------

- Add support for double dash as an argument parsing terminator
- Add bashly doc command to show reference in the terminal


v0.9.2 - 2022-12-16
----------------------------------------

- Fix repeatable arg validation
- Fix all shfmt offenses


v0.9.1 - 2022-12-09
----------------------------------------

- Add support for default command that is used instead of showing usage
- Remove call to root_command when there are sub-commands
- Add the ability to choose .bash as the partials extension


v0.9.0 - 2022-12-02
----------------------------------------

- Refactor with rentactop ruleset
- Fix multiple global flags
- Fix bash completions for commands with global flags
- Allow command.dependencies to be a hash for custom 'how to install' messages
- Normalize examples to include src/*.sh artifacts
- Update approvals.bash (bashly add test) to v0.3.2
- Add help command library (bashly add help)
- Improve generated script format
- Change dependency command checker for testability
- Update approvals.bash (bashly add test) to v0.3.3
- Add ability to define a private environment variable


v0.8.10 - 2022-11-01
----------------------------------------

- Allow command.examples to be a string


v0.8.9 - 2022-10-14
----------------------------------------

- Add --verbose to bashly validate, to show the compiled config
- Add command function directive


v0.8.8 - 2022-10-08
----------------------------------------

- Refactor settings (internal)
- Allow disabling compact flag expansion (-abc to -a -b -c)


v0.8.7 - 2022-09-30
----------------------------------------

- Update validator to alert when a default command has no args
- Make default environment variables values available in initialize()
- Redirect error messages to stderr
- Add support for global command flags
- Update all examples and show global flags use in examples/docker-like


v0.8.6 - 2022-09-23
----------------------------------------

- Fix 'bashly add test'


v0.8.5 - 2022-09-09
----------------------------------------

- Update Filewatcher to ~> 2.0


v0.8.4 - 2022-09-04
----------------------------------------

- Update completely to version 0.5.0


v0.8.3 - 2022-08-16
----------------------------------------

- Switch from ERB to GTX templates
- Upgrade to completely 0.4.3
- Show error instead of usage on invalid command call


v0.8.2 - 2022-06-01
----------------------------------------

- Add command.deep_help option
- Change the group option so that it no longer lingers
- Rename command.deep_help to command.expose
- Add help command example
- Fix parents revalidation issue
- Refactor command.expose to show subcommands without --help when set to 'always'
- Add --watch to the generate command


v0.8.1 - 2022-05-22
----------------------------------------

- Improve non-unique command validation by testing name and aliases together
- Improve bash completion generation
- Fix completions for deep command aliases


v0.8.0 - 2022-05-12
----------------------------------------

- Breaking change: Rename Command.short to Command.alias and add support for multiple values
- Add deprecation warning for command.short
- Validate uniqueness of command args, flags and subcommands


v0.7.10 - 2022-04-29
----------------------------------------

- Disallow catch_all together with repeatable arg
- Refactor parse_requirements views
- Add support for generating tab-indented scripts using BASHLY_TAB_INDENT
- Add settings.yml as an alternative to environment variables
- Support env value in settings.yml as an alternative to BASHLY_ENV


v0.7.9 - 2022-04-02
----------------------------------------

- Add support for repeatable args
- Abort generation if the config file contains unknown keys
- Allow generating script without file marker comments
- Add BASHLY_ENV and bashly generate --env
- Add a help footer when running bashly without arguments


v0.7.8 - 2022-03-11
----------------------------------------

- Remove --version from subcommands


v0.7.7 - 2022-02-20
----------------------------------------

- Add bashly version to generated script header comment
- Fix whitelist filter on repeatable flags
- Add BASHLY_LIB_DIR configuration variable
- Add more friendly errors on invalid configuration
- Adjust YAML loading to allow aliases in Ruby 3.1


v0.7.6 - 2022-02-18
----------------------------------------

- Add support for repeatable flags
- Make args array available in user filters
- Add support for exclusive flags (conflicts)
- Add approvals.bash testing library


v0.7.5 - 2022-02-14
----------------------------------------

- Fix validation when using split config


v0.7.4 - 2022-02-13
----------------------------------------

- Add custom command filters


v0.7.3 - 2022-02-03
----------------------------------------

- Allow specifying filenames for command partials
- Add validations for flag and arg names


v0.7.2 - 2022-01-28
----------------------------------------

- Add support for stdin
- Refactor catch_all (internal)
- Refactor command scopes
- Fix autocomplete in ZSH


v0.7.1 - 2021-11-17
----------------------------------------

- Refactor library handling (internal)
- Make generated scripts compatible with bash strict mode
- Add support for private commands
- Add ability to import external snippets in bashly.yml
- Add basic validation for key config properties
- Validate the entire config prior to generating
- Add bashly validate CLI command


v0.7.0 - 2021-10-29
----------------------------------------

- Allow required args to appear after flags
- Refactor library functions (internal)
- Auto upgrade libraries
- Add support for hidden comments


v0.6.9 - 2021-10-26
----------------------------------------

- Add optional arg/flag validation functions
- Automatically add allowed arguments to completions
- Add more custom validations
- Add support for NO_COLORS


v0.6.8 - 2021-10-12
----------------------------------------

- Add --quiet to bashly generate
- Fix --wrap func generation excess newlines
- Add support for a custom script header
- Improve friendly error on bash 3


v0.6.7 - 2021-09-27
----------------------------------------

- Fix config library context contamination


v0.6.6 - 2021-09-07
----------------------------------------

- Add support for -abc, -a=arg and --flag=arg
- Sort lib files to ensure consistent inclusion


v0.6.5 - 2021-09-03
----------------------------------------

- Upgrade completely gem to allow completions for local scripts


v0.6.4 - 2021-08-27
----------------------------------------

- Exit with zero on --help
- Add support for required catch_all arguments


v0.6.3 - 2021-08-25
----------------------------------------

- Exit gracefully if bash version is < 4


v0.6.2 - 2021-07-27
----------------------------------------

- Add default option for environment variables


v0.6.1 - 2021-07-21
----------------------------------------

- Refactor completions to allow adding custom functions (like git branches)


v0.6.0 - 2021-07-21
----------------------------------------

- Add bash completion generation


v0.5.1 - 2021-07-02
----------------------------------------

- Add support for a custom help footer


v0.5.0 - 2021-06-30
----------------------------------------

- Add support for extensible commands


v0.4.5 - 2021-06-24
----------------------------------------

- Avoid wrapping uninterrupted strings


v0.4.4 - 2021-06-01
----------------------------------------

- Fix catch all help when no args are used


v0.4.3 - 2021-05-08
----------------------------------------

- Add ability to catch arbitrary args and flags


v0.4.2 - 2021-03-04
----------------------------------------

- Remove unused code for --version and --help in root command
- Add support for allowed values for flags
- Add support for whitelist in args


v0.4.1 - 2021-02-20
----------------------------------------

- Add generate --wrap FUNCTION_NAME option to generate sourcing-friendly output


v0.4.1rc1 - 2021-02-18
----------------------------------------

- Change flag arguments (--flag ARG) to allow argument that starts with a dash


v0.4.0 - 2020-10-21
----------------------------------------

- Allow using short name only for flags and change '%{long}' in flag translation to '%{name}'


## [v0.3.9](https://github.com/DannyBen/bashly/tree/v0.3.9) (2020-04-01)

[Full Changelog](https://github.com/DannyBen/bashly/compare/v0.3.8...v0.3.9)

**Implemented enhancements:**

- Consider adding stdlib for trimming a string to $COLUMNS wide [\#52](https://github.com/DannyBen/bashly/issues/52)

**Merged pull requests:**

- Fix config regex to work on mac [\#53](https://github.com/DannyBen/bashly/pull/53) ([DannyBen](https://github.com/DannyBen))
- Config stdlib: allow comments [\#51](https://github.com/DannyBen/bashly/pull/51) ([DannyBen](https://github.com/DannyBen))
- Add config\_has\_key to the config stdlib [\#50](https://github.com/DannyBen/bashly/pull/50) ([DannyBen](https://github.com/DannyBen))

## [v0.3.8](https://github.com/DannyBen/bashly/tree/v0.3.8) (2020-03-02)

[Full Changelog](https://github.com/DannyBen/bashly/compare/v0.3.7...v0.3.8)

**Merged pull requests:**

- Hide \[options\] unless flags are defined [\#49](https://github.com/DannyBen/bashly/pull/49) ([DannyBen](https://github.com/DannyBen))

## [v0.3.7](https://github.com/DannyBen/bashly/tree/v0.3.7) (2020-02-17)

[Full Changelog](https://github.com/DannyBen/bashly/compare/v0.3.6...v0.3.7)

**Merged pull requests:**

- Add support for default values for flags and args [\#48](https://github.com/DannyBen/bashly/pull/48) ([DannyBen](https://github.com/DannyBen))

## [v0.3.6](https://github.com/DannyBen/bashly/tree/v0.3.6) (2020-02-06)

[Full Changelog](https://github.com/DannyBen/bashly/compare/v0.3.5...v0.3.6)

**Merged pull requests:**

- Fix --version to exit with 0 [\#47](https://github.com/DannyBen/bashly/pull/47) ([DannyBen](https://github.com/DannyBen))
- Switch to github actions [\#46](https://github.com/DannyBen/bashly/pull/46) ([DannyBen](https://github.com/DannyBen))
- Resolve ruby warnings [\#45](https://github.com/DannyBen/bashly/pull/45) ([DannyBen](https://github.com/DannyBen))

## [v0.3.5](https://github.com/DannyBen/bashly/tree/v0.3.5) (2019-12-23)

[Full Changelog](https://github.com/DannyBen/bashly/compare/v0.3.4...v0.3.5)

**Merged pull requests:**

- Relinquish -v and -h if the user wants them [\#44](https://github.com/DannyBen/bashly/pull/44) ([DannyBen](https://github.com/DannyBen))

## [v0.3.4](https://github.com/DannyBen/bashly/tree/v0.3.4) (2019-12-19)

[Full Changelog](https://github.com/DannyBen/bashly/compare/v0.3.3...v0.3.4)

**Merged pull requests:**

- Add support for command group captions [\#43](https://github.com/DannyBen/bashly/pull/43) ([DannyBen](https://github.com/DannyBen))

## [v0.3.3](https://github.com/DannyBen/bashly/tree/v0.3.3) (2019-12-13)

[Full Changelog](https://github.com/DannyBen/bashly/compare/v0.3.2...v0.3.3)

**Merged pull requests:**

- Show shortcut in command usage [\#42](https://github.com/DannyBen/bashly/pull/42) ([DannyBen](https://github.com/DannyBen))

## [v0.3.2](https://github.com/DannyBen/bashly/tree/v0.3.2) (2019-12-10)

[Full Changelog](https://github.com/DannyBen/bashly/compare/v0.3.1...v0.3.2)

**Merged pull requests:**

- Replace echo -e with printf for bash 3.2 \(mac\) [\#41](https://github.com/DannyBen/bashly/pull/41) ([DannyBen](https://github.com/DannyBen))
- Test with ruby 2.7 [\#40](https://github.com/DannyBen/bashly/pull/40) ([DannyBen](https://github.com/DannyBen))

## [v0.3.1](https://github.com/DannyBen/bashly/tree/v0.3.1) (2019-11-29)

[Full Changelog](https://github.com/DannyBen/bashly/compare/v0.3.0...v0.3.1)

**Implemented enhancements:**

- Add support for defining dependencies [\#36](https://github.com/DannyBen/bashly/issues/36)

**Merged pull requests:**

- Add support for default command [\#39](https://github.com/DannyBen/bashly/pull/39) ([DannyBen](https://github.com/DannyBen))

## [v0.3.0](https://github.com/DannyBen/bashly/tree/v0.3.0) (2019-11-28)

[Full Changelog](https://github.com/DannyBen/bashly/compare/v0.2.4...v0.3.0)

**Implemented enhancements:**

- Add support for required environment variables [\#35](https://github.com/DannyBen/bashly/issues/35)

**Merged pull requests:**

- Add support for specifying dependencies [\#38](https://github.com/DannyBen/bashly/pull/38) ([DannyBen](https://github.com/DannyBen))
- Add support for required environment variables [\#37](https://github.com/DannyBen/bashly/pull/37) ([DannyBen](https://github.com/DannyBen))
- Sanitize usage strings for quotes [\#34](https://github.com/DannyBen/bashly/pull/34) ([DannyBen](https://github.com/DannyBen))

## [v0.2.4](https://github.com/DannyBen/bashly/tree/v0.2.4) (2019-11-26)

[Full Changelog](https://github.com/DannyBen/bashly/compare/v0.2.3...v0.2.4)

**Implemented enhancements:**

- Automatic support for short commands [\#30](https://github.com/DannyBen/bashly/issues/30)
- Support sub-sub-commands [\#29](https://github.com/DannyBen/bashly/issues/29)

**Merged pull requests:**

- Add YAML standard library [\#33](https://github.com/DannyBen/bashly/pull/33) ([DannyBen](https://github.com/DannyBen))
- Add examples for starts-with command pattern [\#32](https://github.com/DannyBen/bashly/pull/32) ([DannyBen](https://github.com/DannyBen))

## [v0.2.3](https://github.com/DannyBen/bashly/tree/v0.2.3) (2019-11-24)

[Full Changelog](https://github.com/DannyBen/bashly/compare/v0.2.2...v0.2.3)

**Implemented enhancements:**

- Change default help message [\#26](https://github.com/DannyBen/bashly/issues/26)
- Multiline help messages are not showing properly [\#24](https://github.com/DannyBen/bashly/issues/24)

**Merged pull requests:**

- Support endlessly nested commands [\#31](https://github.com/DannyBen/bashly/pull/31) ([DannyBen](https://github.com/DannyBen))
- Improve fixed flags usage texts [\#28](https://github.com/DannyBen/bashly/pull/28) ([DannyBen](https://github.com/DannyBen))
- Remove root command name from user filenames [\#27](https://github.com/DannyBen/bashly/pull/27) ([DannyBen](https://github.com/DannyBen))
- Multiline help message support [\#25](https://github.com/DannyBen/bashly/pull/25) ([DannyBen](https://github.com/DannyBen))

## [v0.2.2](https://github.com/DannyBen/bashly/tree/v0.2.2) (2019-11-22)

[Full Changelog](https://github.com/DannyBen/bashly/compare/v0.2.1...v0.2.2)

**Implemented enhancements:**

- Add ability to retrieve all config values from the config file [\#21](https://github.com/DannyBen/bashly/issues/21)
- Add some script for the user to specify initialization actions [\#17](https://github.com/DannyBen/bashly/issues/17)

**Closed issues:**

- Convert travis shellcheck to a Runfile command that checks all examples [\#20](https://github.com/DannyBen/bashly/issues/20)

**Merged pull requests:**

- Add config\_keys function to config standard lib [\#23](https://github.com/DannyBen/bashly/pull/23) ([DannyBen](https://github.com/DannyBen))
- Improve shellcheck tests [\#22](https://github.com/DannyBen/bashly/pull/22) ([DannyBen](https://github.com/DannyBen))

## [v0.2.1](https://github.com/DannyBen/bashly/tree/v0.2.1) (2019-11-21)

[Full Changelog](https://github.com/DannyBen/bashly/compare/v0.2.0...v0.2.1)

**Fixed bugs:**

- Subcommand with short code and no args does not work [\#16](https://github.com/DannyBen/bashly/issues/16)

**Merged pull requests:**

- Add user level init script [\#19](https://github.com/DannyBen/bashly/pull/19) ([DannyBen](https://github.com/DannyBen))
- Fix short command code bug [\#18](https://github.com/DannyBen/bashly/pull/18) ([DannyBen](https://github.com/DannyBen))

## [v0.2.0](https://github.com/DannyBen/bashly/tree/v0.2.0) (2019-11-21)

[Full Changelog](https://github.com/DannyBen/bashly/compare/v0.1.1...v0.2.0)

**Implemented enhancements:**

- Add ability to generate extra includes [\#11](https://github.com/DannyBen/bashly/issues/11)
- Add ability to define examples and environment variable usage sections [\#10](https://github.com/DannyBen/bashly/issues/10)
- Run shellcheck on generated scripts [\#7](https://github.com/DannyBen/bashly/issues/7)
- Add ability to include custom shell scripts [\#6](https://github.com/DannyBen/bashly/issues/6)
- Make all hard coded strings configurable [\#5](https://github.com/DannyBen/bashly/issues/5)

**Merged pull requests:**

- Add config and colors libraries [\#15](https://github.com/DannyBen/bashly/pull/15) ([DannyBen](https://github.com/DannyBen))
- Add support for extra custom scripts [\#14](https://github.com/DannyBen/bashly/pull/14) ([DannyBen](https://github.com/DannyBen))
- Add support for examples and env vars usage text [\#13](https://github.com/DannyBen/bashly/pull/13) ([DannyBen](https://github.com/DannyBen))
- Custom strings + improvements round [\#12](https://github.com/DannyBen/bashly/pull/12) ([DannyBen](https://github.com/DannyBen))

## [v0.1.1](https://github.com/DannyBen/bashly/tree/v0.1.1) (2019-11-20)

[Full Changelog](https://github.com/DannyBen/bashly/compare/c3d1f18b5247d84afc9e5c89efd30648cb55ccf4...v0.1.1)

**Closed issues:**

- Add documentation for the configuration syntax [\#4](https://github.com/DannyBen/bashly/issues/4)
- Add code climate [\#3](https://github.com/DannyBen/bashly/issues/3)
- Add full integration tests [\#2](https://github.com/DannyBen/bashly/issues/2)

**Merged pull requests:**

- Fix shellcheck warnings [\#9](https://github.com/DannyBen/bashly/pull/9) ([DannyBen](https://github.com/DannyBen))
- Add examples, documentation and integration tests [\#8](https://github.com/DannyBen/bashly/pull/8) ([DannyBen](https://github.com/DannyBen))
- Release fixes and travis test [\#1](https://github.com/DannyBen/bashly/pull/1) ([DannyBen](https://github.com/DannyBen))
