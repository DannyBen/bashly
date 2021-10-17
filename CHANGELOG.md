Change Log
========================================

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
