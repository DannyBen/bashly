Changelog
========================================

v1.2.12 - 2025-05-02
----------------------------------------

- Drop support for Ruby 3.1 [`a735ee00`](https://github.com/DannyBen/bashly/commit/a735ee00)
- Fix validations to only run once [`a3075a02`](https://github.com/DannyBen/bashly/commit/a3075a02)
- Add settings for internal function names [`8fa881e2`](https://github.com/DannyBen/bashly/commit/8fa881e2)
- Compare [`v1.2.11..v1.2.12`](https://github.com/dannyben/bashly/compare/v1.2.11..v1.2.12)


v1.2.11 - 2025-04-04
----------------------------------------

- Fix quoted heredocs [`4b264646`](https://github.com/DannyBen/bashly/commit/4b264646)
- Compare [`v1.2.10..v1.2.11`](https://github.com/dannyben/bashly/compare/v1.2.10..v1.2.11)


v1.2.10 - 2025-02-22
----------------------------------------

- Add `header_override` command option [`d7a57e47`](https://github.com/DannyBen/bashly/commit/d7a57e47)
- Rename `header_override` to `help_header_override` [`2a8b5ded`](https://github.com/DannyBen/bashly/commit/2a8b5ded)
- Add example for `help_header_override` [`aa00c751`](https://github.com/DannyBen/bashly/commit/aa00c751)
- Update JSON schema with `help_header_override` [`6677f4da`](https://github.com/DannyBen/bashly/commit/6677f4da)
- Update `bashly doc` with `command.help_header_override` [`4e50fe17`](https://github.com/DannyBen/bashly/commit/4e50fe17)
- Compare [`v1.2.9..v1.2.10`](https://github.com/dannyben/bashly/compare/v1.2.9..v1.2.10)


v1.2.9 - 2025-01-27
----------------------------------------

- Update colors library to support auto-colors based on TTY [`a4bbae9a`](https://github.com/DannyBen/bashly/commit/a4bbae9a)
- Add `--quiet` to `bashly add` command [`ca0a5468`](https://github.com/DannyBen/bashly/commit/ca0a5468)
- Update documentation domain to bashly.dev [`d05605cb`](https://github.com/DannyBen/bashly/commit/d05605cb)
- Compare [`v1.2.8..v1.2.9`](https://github.com/dannyben/bashly/compare/v1.2.8..v1.2.9)


v1.2.8 - 2025-01-16
----------------------------------------

- Add support for avoiding execution if the script is sourced [`4d83222b`](https://github.com/DannyBen/bashly/commit/4d83222b)
- Revert 9167c49 to allow calling `run ...` internally [`d25c718f`](https://github.com/DannyBen/bashly/commit/d25c718f)
- Declare `version` and `long_usage` as globals for consistency and clarity of intent [`e9a9a76f`](https://github.com/DannyBen/bashly/commit/e9a9a76f)
- Move `long_usage` definition from `initialize` to `run` [`54beb86e`](https://github.com/DannyBen/bashly/commit/54beb86e)
- Add Internal Run example [`4a1b2b9b`](https://github.com/DannyBen/bashly/commit/4a1b2b9b)
- Add support for whalebrew [`f33c663b`](https://github.com/DannyBen/bashly/commit/f33c663b)
- Compare [`v1.2.7..v1.2.8`](https://github.com/dannyben/bashly/compare/v1.2.7..v1.2.8)


v1.2.7 - 2024-12-28
----------------------------------------

- Update version specifications for all dependencies [`6bf0c4a0`](https://github.com/DannyBen/bashly/commit/6bf0c4a0)
- Add support for tweaking production/development output [`c23d7053`](https://github.com/DannyBen/bashly/commit/c23d7053)
- Fix shellcheck unused variable on `other_args` in production [`f78c6e9a`](https://github.com/DannyBen/bashly/commit/f78c6e9a)
- Fix view markers for user files [`cc3896ed`](https://github.com/DannyBen/bashly/commit/cc3896ed)
- Update dependency check to show all missing dependencies at once [`49251064`](https://github.com/DannyBen/bashly/commit/49251064)
- Add support for declaring aliases for internal global variables [`5264d511`](https://github.com/DannyBen/bashly/commit/5264d511)
- Move global var declarations from `run()` to `initialize()` [`9167c498`](https://github.com/DannyBen/bashly/commit/9167c498)
- Update settings JSON schema [`b4e7e4dd`](https://github.com/DannyBen/bashly/commit/b4e7e4dd)
- Add `build` as an alias to `bashly generate` [`d64bc367`](https://github.com/DannyBen/bashly/commit/d64bc367)
- Update default script header [`c85276cd`](https://github.com/DannyBen/bashly/commit/c85276cd)
- Compare [`v1.2.6..v1.2.7`](https://github.com/dannyben/bashly/compare/v1.2.6..v1.2.7)


v1.2.6 - 2024-11-08
----------------------------------------

- Fix array variables scope [`ed7f2404`](https://github.com/DannyBen/bashly/commit/ed7f2404)
- Compare [`v1.2.5..v1.2.6`](https://github.com/dannyben/bashly/compare/v1.2.5..v1.2.6)


v1.2.5 - 2024-11-01
----------------------------------------

- Move root variables from `run()` to `initialize()` [`f76c53b6`](https://github.com/DannyBen/bashly/commit/f76c53b6)
- Compare [`v1.2.4..v1.2.5`](https://github.com/dannyben/bashly/compare/v1.2.4..v1.2.5)


v1.2.4 - 2024-10-31
----------------------------------------

- Add `command.variables` as a convenience utility for defining global command variables [`65388868`](https://github.com/DannyBen/bashly/commit/65388868)
- Update JSON schema to include `command.variables` [`28953fb5`](https://github.com/DannyBen/bashly/commit/28953fb5)
- Refactor `command.variables` to a new `Variable` object [`3e5a0606`](https://github.com/DannyBen/bashly/commit/3e5a0606)
- Add black and white to color library [`0573e0f5`](https://github.com/DannyBen/bashly/commit/0573e0f5)
- Compare [`v1.2.3..v1.2.4`](https://github.com/dannyben/bashly/compare/v1.2.3..v1.2.4)


v1.2.3 - 2024-10-16
----------------------------------------

- Fix docker image for multi-arch [`5660a3e3`](https://github.com/DannyBen/bashly/commit/5660a3e3)
- Fix INI library when loading multiple files [`6bfb1bc0`](https://github.com/DannyBen/bashly/commit/6bfb1bc0)
- Add sub dependencies to avoid Ruby 3.3.5 warnings [`30b7318a`](https://github.com/DannyBen/bashly/commit/30b7318a)
- Fix `conflicts` in fixed flags [`152069af`](https://github.com/DannyBen/bashly/commit/152069af)
- Compare [`v1.2.2..v1.2.3`](https://github.com/dannyben/bashly/compare/v1.2.2..v1.2.3)


v1.2.2 - 2024-08-17
----------------------------------------

- Add support for needy flags: `flag.needs` [`fadda94d`](https://github.com/DannyBen/bashly/commit/fadda94d)
- Add needy flag example [`43e3b386`](https://github.com/DannyBen/bashly/commit/43e3b386)
- Update JSON schemas [`868650c6`](https://github.com/DannyBen/bashly/commit/868650c6)
- Update flag usage to show its conflicts and needs [`db23575c`](https://github.com/DannyBen/bashly/commit/db23575c)
- Refactor Command#introspection [`a66db36f`](https://github.com/DannyBen/bashly/commit/a66db36f)
- Add support for environment variable validations [`bccd3b02`](https://github.com/DannyBen/bashly/commit/bccd3b02)
- Update validations example to show environment variable validation [`ee6a4c99`](https://github.com/DannyBen/bashly/commit/ee6a4c99)
- Update script generation to allow bash variables in some YAML strings [`6660d168`](https://github.com/DannyBen/bashly/commit/6660d168)
- Allow ad-hoc revealing of private commands, flags, and environment variables [`d2876d72`](https://github.com/DannyBen/bashly/commit/d2876d72)
- Add private-reveal example [`8c940429`](https://github.com/DannyBen/bashly/commit/8c940429)
- Update completions library to consider private visibility setting [`e16dde10`](https://github.com/DannyBen/bashly/commit/e16dde10)
- Update mandoc/markdown library to consider private visibility setting [`c49d94df`](https://github.com/DannyBen/bashly/commit/c49d94df)
- Compare [`v1.2.1..v1.2.2`](https://github.com/dannyben/bashly/compare/v1.2.1..v1.2.2)


v1.2.1 - 2024-07-25
----------------------------------------

- Add validation to disallow required args before optional [`f2d62764`](https://github.com/DannyBen/bashly/commit/f2d62764)
- Fix shellcheck violations and reduce use of `eval` [`41da133a`](https://github.com/DannyBen/bashly/commit/41da133a)
- Fix default command not being triggered when only flags are provided [`c6598300`](https://github.com/DannyBen/bashly/commit/c6598300)
- Fix prompt in bashly shell [`de231e89`](https://github.com/DannyBen/bashly/commit/de231e89)
- Compare [`v1.2.0..v1.2.1`](https://github.com/dannyben/bashly/compare/v1.2.0..v1.2.1)


v1.2.0 - 2024-07-05
----------------------------------------

- Fix usage string when there is a forced default command [`d50607be`](https://github.com/DannyBen/bashly/commit/d50607be)
- Add 'Global options' caption when appropriate [`105a0f89`](https://github.com/DannyBen/bashly/commit/105a0f89)
- Update descriptions in schemas/strings.json [`6592666f`](https://github.com/DannyBen/bashly/commit/6592666f)
- Remove redundant code in usage function [`f87986a7`](https://github.com/DannyBen/bashly/commit/f87986a7)
- Update default command usage to show optional brackets [`854036d5`](https://github.com/DannyBen/bashly/commit/854036d5)
- Add `show_examples_on_error` setting [`5e58388d`](https://github.com/DannyBen/bashly/commit/5e58388d)
- Add examples/command-examples-on-error [`b30d2aa1`](https://github.com/DannyBen/bashly/commit/b30d2aa1)
- Compare [`v1.1.10..v1.2.0`](https://github.com/dannyben/bashly/compare/v1.1.10..v1.2.0)


v1.1.10 - 2024-04-01
----------------------------------------

- Sanitize percent signs in help messages [`1f7e27c5`](https://github.com/DannyBen/bashly/commit/1f7e27c5)
- Drop support for Ruby 3.0 [`865d6ac7`](https://github.com/DannyBen/bashly/commit/865d6ac7)
- Fix input normalization to ignore anything after the double dash (--) operator [`621a1513`](https://github.com/DannyBen/bashly/commit/621a1513)
- Add `[--]` to usage text when `catch_all` is used [`1422bcf3`](https://github.com/DannyBen/bashly/commit/1422bcf3)
- Add `conjoined_flag_args` to allow disabling the `--flag=arg` normalization [`d17756d2`](https://github.com/DannyBen/bashly/commit/d17756d2)
- Compare [`v1.1.9..v1.1.10`](https://github.com/dannyben/bashly/compare/v1.1.9..v1.1.10)


v1.1.9 - 2024-03-20
----------------------------------------

- Fix repeatable args when the input has quotes [`0d35217b`](https://github.com/DannyBen/bashly/commit/0d35217b)
- Fix repeatable flag args when the input has quotes [`ab34fc05`](https://github.com/DannyBen/bashly/commit/ab34fc05)
- Improve handling of unique repeatable args and flag args [`c200223a`](https://github.com/DannyBen/bashly/commit/c200223a)
- Update `Approvals.bash` to v0.5.1 [`8e12d559`](https://github.com/DannyBen/bashly/commit/8e12d559)
- Compare [`v1.1.8..v1.1.9`](https://github.com/dannyben/bashly/compare/v1.1.8..v1.1.9)


v1.1.8 - 2024-03-02
----------------------------------------

- Update `approvals.bash` to v0.5.0 [`530cb05d`](https://github.com/DannyBen/bashly/commit/530cb05d)
- Add support for using heredoc [`adf4837f`](https://github.com/DannyBen/bashly/commit/adf4837f)
- Compare [`v1.1.7..v1.1.8`](https://github.com/dannyben/bashly/compare/v1.1.7..v1.1.8)


v1.1.7 - 2024-02-17
----------------------------------------

- Refactor validations to run after assigning default values [`e45580cd`](https://github.com/DannyBen/bashly/commit/e45580cd)
- Upgrade `approvals.bash` to 0.4.2 [`863bf9a5`](https://github.com/DannyBen/bashly/commit/863bf9a5)
- Compare [`v1.1.6..v1.1.7`](https://github.com/dannyben/bashly/compare/v1.1.6..v1.1.7)


v1.1.6 - 2024-02-08
----------------------------------------

- Docker: Fix missing pandoc [`b8f6d2cf`](https://github.com/DannyBen/bashly/commit/b8f6d2cf)
- Avoid rendering `inspect_args()` when generating for production env [`dbb8816b`](https://github.com/DannyBen/bashly/commit/dbb8816b)
- Update `approvals.bash` library to 0.4.1 [`9eee25ca`](https://github.com/DannyBen/bashly/commit/9eee25ca)
- Update Dockerfile [`45344972`](https://github.com/DannyBen/bashly/commit/45344972)
- Build multi-arch docker image using GitHub Actions [`5d169261`](https://github.com/DannyBen/bashly/commit/5d169261)
- Compare [`v1.1.5..v1.1.6`](https://github.com/dannyben/bashly/compare/v1.1.5..v1.1.6)


v1.1.5 - 2023-12-22
----------------------------------------

- Allow `flag.default` and `arg.default` to be an array if `repeatable` is true [`00c81ec1`](https://github.com/DannyBen/bashly/commit/00c81ec1)
- Improve JSON schema tests [`6bd7a1b6`](https://github.com/DannyBen/bashly/commit/6bd7a1b6)
- Add YAML schema as a source to the bashly JSON schema [`261d1040`](https://github.com/DannyBen/bashly/commit/261d1040)
- Add `allowed` option to `environment_variable` [`4d313a86`](https://github.com/DannyBen/bashly/commit/4d313a86)
- Update `inspect_args` to also print managed `environment_variables` [`4fe17b71`](https://github.com/DannyBen/bashly/commit/4fe17b71)
- Refactor `inspect_args` handling of environment variables [`7c6e7124`](https://github.com/DannyBen/bashly/commit/7c6e7124)
- Compare [`v1.1.4..v1.1.5`](https://github.com/dannyben/bashly/compare/v1.1.4..v1.1.5)


v1.1.4 - 2023-12-09
----------------------------------------

- Fix example in `bashly doc flag.arg` [`039ab1cb`](https://github.com/DannyBen/bashly/commit/039ab1cb)
- Add support for `unique` in repeatable flag args [`b062c934`](https://github.com/DannyBen/bashly/commit/b062c934)
- Disallow multiple repeatable args, and a repeatable arg that is not the last one [`25431c9e`](https://github.com/DannyBen/bashly/commit/25431c9e)
- Add support for `unique` in repeatable args [`4486788f`](https://github.com/DannyBen/bashly/commit/4486788f)
- Compare [`v1.1.3..v1.1.4`](https://github.com/dannyben/bashly/compare/v1.1.3..v1.1.4)


v1.1.3 - 2023-11-25
----------------------------------------

- Fix `bashly completeions --install` [`9e5d45a0`](https://github.com/DannyBen/bashly/commit/9e5d45a0)
- Compare [`v1.1.2..v1.1.3`](https://github.com/dannyben/bashly/compare/v1.1.2..v1.1.3)


v1.1.2 - 2023-11-15
----------------------------------------

- Fix shfmt excess newlines violation when using `--env production` [`0938fca1`](https://github.com/DannyBen/bashly/commit/0938fca1)
- Fix some incompatibilities with strict mode [`b24cddff`](https://github.com/DannyBen/bashly/commit/b24cddff)
- Compare [`v1.1.1..v1.1.2`](https://github.com/dannyben/bashly/compare/v1.1.1..v1.1.2)


v1.1.1 - 2023-10-18
----------------------------------------

- Upgrade `approvals.bash` library to version 0.4.0 [`a68ad34f`](https://github.com/DannyBen/bashly/commit/a68ad34f)
- Update INI library to allow using environment variables in the INI values [`2e3aec7f`](https://github.com/DannyBen/bashly/commit/2e3aec7f)
- Add support for custom "See Also" in mandoc renderer (`x_mandoc_see_also`) [`4fddc7bf`](https://github.com/DannyBen/bashly/commit/4fddc7bf)
- Fix missing tmpdir library in `bashly add --source` [`3f7b4c3a`](https://github.com/DannyBen/bashly/commit/3f7b4c3a)
- Validate libraries.yml [`a44cbde9`](https://github.com/DannyBen/bashly/commit/a44cbde9)
- Compare [`v1.1.0..v1.1.1`](https://github.com/dannyben/bashly/compare/v1.1.0..v1.1.1)


v1.1.0 - 2023-08-28
----------------------------------------

- Add `bashly render` command [`4acc67bd`](https://github.com/DannyBen/bashly/commit/4acc67bd)
- Add ability to render markdown documentation [`7db61291`](https://github.com/DannyBen/bashly/commit/7db61291)
- Refactor module loading with autoload [`62184f0f`](https://github.com/DannyBen/bashly/commit/62184f0f)
- Add `bashly add render_markdown` library [`d0fada7d`](https://github.com/DannyBen/bashly/commit/d0fada7d)
- Add ability to render man pages and `bashly add render_mandoc` library [`fe9607b4`](https://github.com/DannyBen/bashly/commit/fe9607b4)
- Refactor render command with RenderSource model [`8629d266`](https://github.com/DannyBen/bashly/commit/8629d266)
- Allow arbitrary (`x-anything`) values in bashly.yml [`90627833`](https://github.com/DannyBen/bashly/commit/90627833)
- Refactor mandoc template to use x_mandoc_footer and x_mandoc_authors [`b44b91f9`](https://github.com/DannyBen/bashly/commit/b44b91f9)
- Add render-mandoc man page generation example [`98420de1`](https://github.com/DannyBen/bashly/commit/98420de1)
- Add `--show` to `bashly render` [`2fcd790b`](https://github.com/DannyBen/bashly/commit/2fcd790b)
- Compare [`v1.0.8..v1.1.0`](https://github.com/dannyben/bashly/compare/v1.0.8..v1.1.0)


<!-- break v1.0.8 -->
v1.0.8 - 2023-08-11
----------------------------------------

- Add ini library for handling INI files with sections [`e0b1e43`](https://github.com/DannyBen/bashly/commit/e0b1e43)
- Config Library: Add ability to set default value in `config_get` [`d879ae1`](https://github.com/DannyBen/bashly/commit/d879ae1)
- Config Library: Refactor to allow sections and use the low level INI library [`f2ce7f5`](https://github.com/DannyBen/bashly/commit/f2ce7f5)
- Gemspec: Add Psych dependency [`3db496b`](https://github.com/DannyBen/bashly/commit/3db496b)
- Compare [`v1.0.7..v1.0.8`](https://github.com/dannyben/bashly/compare/v1.0.7..v1.0.8)


v1.0.7 - 2023-07-07
----------------------------------------

- Add support for auto-organizing command files in subfolders [`c777968`](https://github.com/DannyBen/bashly/commit/c777968)
- Pre-process config files using ERB [`5e9cda4`](https://github.com/DannyBen/bashly/commit/5e9cda4)
- Compare [`v1.0.6..v1.0.7`](https://github.com/dannyben/bashly/compare/v1.0.6..v1.0.7)


v1.0.6 - 2023-06-27
----------------------------------------

- Add completions for bashly itself [`2f17228`](https://github.com/DannyBen/bashly/commit/2f17228)
- Add `bashly completions --install` command [`3f4b1a3`](https://github.com/DannyBen/bashly/commit/3f4b1a3)
- Upgrade completely version to 0.6.0 [`b9217aa`](https://github.com/DannyBen/bashly/commit/b9217aa)
- Add `bashly completions --uininstall` command [`706b121`](https://github.com/DannyBen/bashly/commit/706b121)
- Upgrade completely version to 0.6.1 [`0c293ac`](https://github.com/DannyBen/bashly/commit/0c293ac)
- Remove colors from `bashly shell` prompt [`30d1e87`](https://github.com/DannyBen/bashly/commit/30d1e87)
- Compare [`v1.0.5..v1.0.6`](https://github.com/dannyben/bashly/compare/v1.0.5..v1.0.6)


v1.0.5 - 2023-06-02
----------------------------------------

- Add bashly interactive shell [`66f0115`](https://github.com/DannyBen/bashly/commit/66f0115)
- Compare [`v1.0.4..v1.0.5`](https://github.com/dannyben/bashly/compare/v1.0.4..v1.0.5)


v1.0.4 - 2023-05-02
----------------------------------------

- Allow using `bashly-settings.yml` instead of `settings.yml` [`f4d1f66`](https://github.com/DannyBen/bashly/commit/f4d1f66)
- Fix completions library to not show private commands [`3002a61`](https://github.com/DannyBen/bashly/commit/3002a61)
- Fix completions library to not show private flags [`4206b04`](https://github.com/DannyBen/bashly/commit/4206b04)
- Compare [`v1.0.3..v1.0.4`](https://github.com/dannyben/bashly/compare/v1.0.3..v1.0.4)


v1.0.3 - 2023-04-08
----------------------------------------

- Move 'initialize.sh' to 'bashly add hooks' [`8070b3d`](https://github.com/DannyBen/bashly/commit/8070b3d)
- Drop support for ruby 2.7 [`60f72e4`](https://github.com/DannyBen/bashly/commit/60f72e4)
- Add validation alert when 'allowed' is provided without either a 'default' or 'required' [`6e84cba`](https://github.com/DannyBen/bashly/commit/6e84cba)
- Update validation errors to highlight words that are YAML options [`176fb1e`](https://github.com/DannyBen/bashly/commit/176fb1e)
- Fix arg.allowed and flag.allowed to allow setting without 'required' or 'default' [`1601075`](https://github.com/DannyBen/bashly/commit/1601075)
- Fix 'default' and 'required' for flags with a short name only [`f57f611`](https://github.com/DannyBen/bashly/commit/f57f611)
- Compare [`v1.0.2..v1.0.3`](https://github.com/dannyben/bashly/compare/v1.0.2..v1.0.3)


v1.0.2 - 2023-03-23
----------------------------------------

- Do not add dependencies-filter view marker when there are no dependencies [`b960ded`](https://github.com/DannyBen/bashly/commit/b960ded)
- Fix initialize.bash not being injected [`35d99ed`](https://github.com/DannyBen/bashly/commit/35d99ed)
- Add before/after hooks [`7665904`](https://github.com/DannyBen/bashly/commit/7665904)
- Add 'bashly add hooks' command [`c0ce610`](https://github.com/DannyBen/bashly/commit/c0ce610)
- Add hooks example [`7690098`](https://github.com/DannyBen/bashly/commit/7690098)
- Compare [`v1.0.1..v1.0.2`](https://github.com/dannyben/bashly/compare/v1.0.1..v1.0.2)


v1.0.1 - 2023-03-03
----------------------------------------

- Allow dot in command.name [`a4ea0fa`](https://github.com/DannyBen/bashly/commit/a4ea0fa)
- Change settings.strict to allow any string [`7072bf8`](https://github.com/DannyBen/bashly/commit/7072bf8)
- Update dependencies option to support 'any' (e.g. wget or curl) [`c3edf8c`](https://github.com/DannyBen/bashly/commit/c3edf8c)
- Add a 'deps' associative array to the generated bash script [`02701df`](https://github.com/DannyBen/bashly/commit/02701df)
- Compare [`v1.0.0..v1.0.1`](https://github.com/dannyben/bashly/compare/v1.0.0..v1.0.1)


v1.0.0 - 2023-02-16
----------------------------------------

- Show --help and --version last in Options list [`b825ad8`](https://github.com/DannyBen/bashly/commit/b825ad8)
- Fix environment variables caption to not show if all are private [`9b55da5`](https://github.com/DannyBen/bashly/commit/9b55da5)
- Remove env var validation rule for private + default [`2c5b4f7`](https://github.com/DannyBen/bashly/commit/2c5b4f7)
- Add support for private flags [`de6e5a2`](https://github.com/DannyBen/bashly/commit/de6e5a2)
- Allow configuring the path to bashly.yml [`facd6ce`](https://github.com/DannyBen/bashly/commit/facd6ce)
- Allow customizing the path to settings.yml [`b65870d`](https://github.com/DannyBen/bashly/commit/b65870d)
- Remove environment variables from all --help messages [`44df91c`](https://github.com/DannyBen/bashly/commit/44df91c)
- Refactor libraries [`3139d59`](https://github.com/DannyBen/bashly/commit/3139d59)
- Refactor 'bashly add libraries' command [`5cf63e3`](https://github.com/DannyBen/bashly/commit/5cf63e3)
- Add support for adding libraries from a custom directory [`ea124cf`](https://github.com/DannyBen/bashly/commit/ea124cf)
- Add support for git-sourced libraries [`bcd35dc`](https://github.com/DannyBen/bashly/commit/bcd35dc)
- Add auto upgrade support to custom library sources [`470c9c6`](https://github.com/DannyBen/bashly/commit/470c9c6)
- Remove deprecated command.short [`b82b70a`](https://github.com/DannyBen/bashly/commit/b82b70a)
- Add command.name validation [`0c74891`](https://github.com/DannyBen/bashly/commit/0c74891)
- Compare [`v0.9.5..v1.0.0`](https://github.com/dannyben/bashly/compare/v0.9.5..v1.0.0)


v0.9.5 - 2023-01-31
----------------------------------------

- Upgrade dependencies [`0319ade`](https://github.com/DannyBen/bashly/commit/0319ade)
- Compare [`v0.9.4..v0.9.5`](https://github.com/dannyben/bashly/compare/v0.9.4..v0.9.5)


v0.9.4 - 2022-12-31
----------------------------------------

- Fix validate --verbose command [`4b07c85`](https://github.com/DannyBen/bashly/commit/4b07c85)
- Add support for color usage elements [`f4c8086`](https://github.com/DannyBen/bashly/commit/f4c8086)
- Compare [`v0.9.3..v0.9.4`](https://github.com/dannyben/bashly/compare/v0.9.3..v0.9.4)


v0.9.3 - 2022-12-24
----------------------------------------

- Add support for double dash as an argument parsing terminator [`370982e`](https://github.com/DannyBen/bashly/commit/370982e)
- Add bashly doc command to show reference in the terminal [`d5026e0`](https://github.com/DannyBen/bashly/commit/d5026e0)
- Compare [`v0.9.2..v0.9.3`](https://github.com/dannyben/bashly/compare/v0.9.2..v0.9.3)


v0.9.2 - 2022-12-16
----------------------------------------

- Fix repeatable arg validation [`ed93445`](https://github.com/DannyBen/bashly/commit/ed93445)
- Fix all shfmt offenses [`c997fa8`](https://github.com/DannyBen/bashly/commit/c997fa8)
- Compare [`v0.9.1..v0.9.2`](https://github.com/dannyben/bashly/compare/v0.9.1..v0.9.2)


v0.9.1 - 2022-12-09
----------------------------------------

- Add support for default command that is used instead of showing usage [`bb20e6c`](https://github.com/DannyBen/bashly/commit/bb20e6c)
- Remove call to root_command when there are sub-commands [`60db5bf`](https://github.com/DannyBen/bashly/commit/60db5bf)
- Add the ability to choose .bash as the partials extension [`ad8605d`](https://github.com/DannyBen/bashly/commit/ad8605d)
- Compare [`v0.9.0..v0.9.1`](https://github.com/dannyben/bashly/compare/v0.9.0..v0.9.1)


v0.9.0 - 2022-12-02
----------------------------------------

- Refactor with rentactop ruleset [`50ed3d0`](https://github.com/DannyBen/bashly/commit/50ed3d0)
- Fix multiple global flags [`d9e339d`](https://github.com/DannyBen/bashly/commit/d9e339d)
- Fix bash completions for commands with global flags [`6c52c52`](https://github.com/DannyBen/bashly/commit/6c52c52)
- Allow command.dependencies to be a hash for custom 'how to install' messages [`558f3f7`](https://github.com/DannyBen/bashly/commit/558f3f7)
- Normalize examples to include src/*.sh artifacts [`9ad208d`](https://github.com/DannyBen/bashly/commit/9ad208d)
- Update approvals.bash (bashly add test) to v0.3.2 [`070a2b3`](https://github.com/DannyBen/bashly/commit/070a2b3)
- Add help command library (bashly add help) [`d739db7`](https://github.com/DannyBen/bashly/commit/d739db7)
- Improve generated script format [`8f7b529`](https://github.com/DannyBen/bashly/commit/8f7b529)
- Change dependency command checker for testability [`9683e16`](https://github.com/DannyBen/bashly/commit/9683e16)
- Update approvals.bash (bashly add test) to v0.3.3 [`4f1053d`](https://github.com/DannyBen/bashly/commit/4f1053d)
- Add ability to define a private environment variable [`5a7634f`](https://github.com/DannyBen/bashly/commit/5a7634f)
- Compare [`v0.8.10..v0.9.0`](https://github.com/dannyben/bashly/compare/v0.8.10..v0.9.0)


v0.8.10 - 2022-11-01
----------------------------------------

- Allow command.examples to be a string [`bac91f2`](https://github.com/DannyBen/bashly/commit/bac91f2)
- Compare [`v0.8.9..v0.8.10`](https://github.com/dannyben/bashly/compare/v0.8.9..v0.8.10)


v0.8.9 - 2022-10-14
----------------------------------------

- Add --verbose to bashly validate, to show the compiled config [`fe04c9e`](https://github.com/DannyBen/bashly/commit/fe04c9e)
- Add command function directive [`4010361`](https://github.com/DannyBen/bashly/commit/4010361)
- Compare [`v0.8.8..v0.8.9`](https://github.com/dannyben/bashly/compare/v0.8.8..v0.8.9)


v0.8.8 - 2022-10-08
----------------------------------------

- Refactor settings (internal) [`e19b9c7`](https://github.com/DannyBen/bashly/commit/e19b9c7)
- Allow disabling compact flag expansion (-abc to -a -b -c) [`0554c22`](https://github.com/DannyBen/bashly/commit/0554c22)
- Compare [`v0.8.7..v0.8.8`](https://github.com/dannyben/bashly/compare/v0.8.7..v0.8.8)


v0.8.7 - 2022-09-30
----------------------------------------

- Update validator to alert when a default command has no args [`cfbb038`](https://github.com/DannyBen/bashly/commit/cfbb038)
- Make default environment variables values available in initialize() [`d37a214`](https://github.com/DannyBen/bashly/commit/d37a214)
- Redirect error messages to stderr [`54008d2`](https://github.com/DannyBen/bashly/commit/54008d2)
- Add support for global command flags [`512338a`](https://github.com/DannyBen/bashly/commit/512338a)
- Update all examples and show global flags use in examples/docker-like [`70f975d`](https://github.com/DannyBen/bashly/commit/70f975d)
- Compare [`v0.8.6..v0.8.7`](https://github.com/dannyben/bashly/compare/v0.8.6..v0.8.7)


v0.8.6 - 2022-09-23
----------------------------------------

- Fix 'bashly add test' [`41d65f8`](https://github.com/DannyBen/bashly/commit/41d65f8)
- Compare [`v0.8.5..v0.8.6`](https://github.com/dannyben/bashly/compare/v0.8.5..v0.8.6)


v0.8.5 - 2022-09-09
----------------------------------------

- Update Filewatcher to ~> 2.0 [`51fa854`](https://github.com/DannyBen/bashly/commit/51fa854)
- Compare [`v0.8.4..v0.8.5`](https://github.com/dannyben/bashly/compare/v0.8.4..v0.8.5)


v0.8.4 - 2022-09-04
----------------------------------------

- Update completely to version 0.5.0 [`f764a53`](https://github.com/DannyBen/bashly/commit/f764a53)
- Compare [`v0.8.3..v0.8.4`](https://github.com/dannyben/bashly/compare/v0.8.3..v0.8.4)


v0.8.3 - 2022-08-16
----------------------------------------

- Switch from ERB to GTX templates [`330945b`](https://github.com/DannyBen/bashly/commit/330945b)
- Upgrade to completely 0.4.3 [`3964452`](https://github.com/DannyBen/bashly/commit/3964452)
- Show error instead of usage on invalid command call [`fa623e6`](https://github.com/DannyBen/bashly/commit/fa623e6)
- Compare [`v0.8.2..v0.8.3`](https://github.com/dannyben/bashly/compare/v0.8.2..v0.8.3)


v0.8.2 - 2022-06-01
----------------------------------------

- Add command.deep_help option [`aeef258`](https://github.com/DannyBen/bashly/commit/aeef258)
- Change the group option so that it no longer lingers [`5690c4a`](https://github.com/DannyBen/bashly/commit/5690c4a)
- Rename command.deep_help to command.expose [`1efb2a6`](https://github.com/DannyBen/bashly/commit/1efb2a6)
- Add help command example [`6011426`](https://github.com/DannyBen/bashly/commit/6011426)
- Fix parents revalidation issue [`2efb8cd`](https://github.com/DannyBen/bashly/commit/2efb8cd)
- Refactor command.expose to show subcommands without --help when set to 'always' [`2227fdc`](https://github.com/DannyBen/bashly/commit/2227fdc)
- Add --watch to the generate command [`ee2cf92`](https://github.com/DannyBen/bashly/commit/ee2cf92)
- Compare [`v0.8.1..v0.8.2`](https://github.com/dannyben/bashly/compare/v0.8.1..v0.8.2)


v0.8.1 - 2022-05-22
----------------------------------------

- Improve non-unique command validation by testing name and aliases together [`4f00423`](https://github.com/DannyBen/bashly/commit/4f00423)
- Improve bash completion generation [`be9b05c`](https://github.com/DannyBen/bashly/commit/be9b05c)
- Fix completions for deep command aliases [`d7ea262`](https://github.com/DannyBen/bashly/commit/d7ea262)
- Compare [`v0.8.0..v0.8.1`](https://github.com/dannyben/bashly/compare/v0.8.0..v0.8.1)


v0.8.0 - 2022-05-12
----------------------------------------

- Breaking change: Rename Command.short to Command.alias and add support for multiple values [`b7b8dc1`](https://github.com/DannyBen/bashly/commit/b7b8dc1)
- Add deprecation warning for command.short [`8d5b656`](https://github.com/DannyBen/bashly/commit/8d5b656)
- Validate uniqueness of command args, flags and subcommands [`c4e2553`](https://github.com/DannyBen/bashly/commit/c4e2553)
- Compare [`v0.7.10..v0.8.0`](https://github.com/dannyben/bashly/compare/v0.7.10..v0.8.0)


v0.7.10 - 2022-04-29
----------------------------------------

- Disallow catch_all together with repeatable arg [`6a8c8c8`](https://github.com/DannyBen/bashly/commit/6a8c8c8)
- Refactor parse_requirements views [`b9c38d4`](https://github.com/DannyBen/bashly/commit/b9c38d4)
- Add support for generating tab-indented scripts using BASHLY_TAB_INDENT [`9ff5551`](https://github.com/DannyBen/bashly/commit/9ff5551)
- Add settings.yml as an alternative to environment variables [`dd95436`](https://github.com/DannyBen/bashly/commit/dd95436)
- Support env value in settings.yml as an alternative to BASHLY_ENV [`15f92e3`](https://github.com/DannyBen/bashly/commit/15f92e3)
- Compare [`v0.7.9..v0.7.10`](https://github.com/dannyben/bashly/compare/v0.7.9..v0.7.10)


v0.7.9 - 2022-04-02
----------------------------------------

- Add support for repeatable args [`74f0ce3`](https://github.com/DannyBen/bashly/commit/74f0ce3)
- Abort generation if the config file contains unknown keys [`58f8777`](https://github.com/DannyBen/bashly/commit/58f8777)
- Allow generating script without file marker comments [`cf8257d`](https://github.com/DannyBen/bashly/commit/cf8257d)
- Add BASHLY_ENV and bashly generate --env [`93c9446`](https://github.com/DannyBen/bashly/commit/93c9446)
- Add a help footer when running bashly without arguments [`1b851ba`](https://github.com/DannyBen/bashly/commit/1b851ba)
- Compare [`v0.7.8..v0.7.9`](https://github.com/dannyben/bashly/compare/v0.7.8..v0.7.9)


v0.7.8 - 2022-03-11
----------------------------------------

- Remove --version from subcommands [`6886475`](https://github.com/DannyBen/bashly/commit/6886475)
- Compare [`v0.7.7..v0.7.8`](https://github.com/dannyben/bashly/compare/v0.7.7..v0.7.8)


v0.7.7 - 2022-02-20
----------------------------------------

- Add bashly version to generated script header comment [`806d3e1`](https://github.com/DannyBen/bashly/commit/806d3e1)
- Fix whitelist filter on repeatable flags [`3af73d9`](https://github.com/DannyBen/bashly/commit/3af73d9)
- Add BASHLY_LIB_DIR configuration variable [`4eea1f2`](https://github.com/DannyBen/bashly/commit/4eea1f2)
- Add more friendly errors on invalid configuration [`5c0e230`](https://github.com/DannyBen/bashly/commit/5c0e230)
- Adjust YAML loading to allow aliases in Ruby 3.1 [`a67b52f`](https://github.com/DannyBen/bashly/commit/a67b52f)
- Compare [`v0.7.6..v0.7.7`](https://github.com/dannyben/bashly/compare/v0.7.6..v0.7.7)


v0.7.6 - 2022-02-18
----------------------------------------

- Add support for repeatable flags [`fa692a9`](https://github.com/DannyBen/bashly/commit/fa692a9)
- Make args array available in user filters [`1e09ed5`](https://github.com/DannyBen/bashly/commit/1e09ed5)
- Add support for exclusive flags (conflicts) [`ef95fbe`](https://github.com/DannyBen/bashly/commit/ef95fbe)
- Add approvals.bash testing library [`f898659`](https://github.com/DannyBen/bashly/commit/f898659)
- Compare [`v0.7.5..v0.7.6`](https://github.com/dannyben/bashly/compare/v0.7.5..v0.7.6)


v0.7.5 - 2022-02-14
----------------------------------------

- Fix validation when using split config [`2d9373e`](https://github.com/DannyBen/bashly/commit/2d9373e)
- Compare [`v0.7.4..v0.7.5`](https://github.com/dannyben/bashly/compare/v0.7.4..v0.7.5)


v0.7.4 - 2022-02-13
----------------------------------------

- Add custom command filters [`436f175`](https://github.com/DannyBen/bashly/commit/436f175)
- Compare [`v0.7.3..v0.7.4`](https://github.com/dannyben/bashly/compare/v0.7.3..v0.7.4)


v0.7.3 - 2022-02-03
----------------------------------------

- Allow specifying filenames for command partials [`a5065c3`](https://github.com/DannyBen/bashly/commit/a5065c3)
- Add validations for flag and arg names [`c768d0b`](https://github.com/DannyBen/bashly/commit/c768d0b)
- Compare [`v0.7.2..v0.7.3`](https://github.com/dannyben/bashly/compare/v0.7.2..v0.7.3)


v0.7.2 - 2022-01-28
----------------------------------------

- Add support for stdin [`d95a864`](https://github.com/DannyBen/bashly/commit/d95a864)
- Refactor catch_all (internal) [`9bda55c`](https://github.com/DannyBen/bashly/commit/9bda55c)
- Refactor command scopes [`2291269`](https://github.com/DannyBen/bashly/commit/2291269)
- Fix autocomplete in ZSH [`3e55adc`](https://github.com/DannyBen/bashly/commit/3e55adc)
- Compare [`v0.7.1..v0.7.2`](https://github.com/dannyben/bashly/compare/v0.7.1..v0.7.2)


v0.7.1 - 2021-11-17
----------------------------------------

- Refactor library handling (internal) [`adefbb1`](https://github.com/DannyBen/bashly/commit/adefbb1)
- Make generated scripts compatible with bash strict mode [`1b406e1`](https://github.com/DannyBen/bashly/commit/1b406e1)
- Add support for private commands [`e3c3217`](https://github.com/DannyBen/bashly/commit/e3c3217)
- Add ability to import external snippets in bashly.yml [`a58df1a`](https://github.com/DannyBen/bashly/commit/a58df1a)
- Add basic validation for key config properties [`ce85408`](https://github.com/DannyBen/bashly/commit/ce85408)
- Validate the entire config prior to generating [`828358f`](https://github.com/DannyBen/bashly/commit/828358f)
- Add bashly validate CLI command [`03e08db`](https://github.com/DannyBen/bashly/commit/03e08db)
- Compare [`v0.7.0..v0.7.1`](https://github.com/dannyben/bashly/compare/v0.7.0..v0.7.1)


v0.7.0 - 2021-10-29
----------------------------------------

- Allow required args to appear after flags [`fba6109`](https://github.com/DannyBen/bashly/commit/fba6109)
- Refactor library functions (internal) [`a78b4c9`](https://github.com/DannyBen/bashly/commit/a78b4c9)
- Auto upgrade libraries [`17fd839`](https://github.com/DannyBen/bashly/commit/17fd839)
- Add support for hidden comments [`efe00a3`](https://github.com/DannyBen/bashly/commit/efe00a3)
- Compare [`v0.6.9..v0.7.0`](https://github.com/dannyben/bashly/compare/v0.6.9..v0.7.0)


v0.6.9 - 2021-10-26
----------------------------------------

- Add optional arg/flag validation functions [`bafa806`](https://github.com/DannyBen/bashly/commit/bafa806)
- Automatically add allowed arguments to completions [`567d194`](https://github.com/DannyBen/bashly/commit/567d194)
- Add more custom validations [`fc63e42`](https://github.com/DannyBen/bashly/commit/fc63e42)
- Add support for NO_COLORS [`1ae60a2`](https://github.com/DannyBen/bashly/commit/1ae60a2)
- Compare [`v0.6.8..v0.6.9`](https://github.com/dannyben/bashly/compare/v0.6.8..v0.6.9)


v0.6.8 - 2021-10-12
----------------------------------------

- Add --quiet to bashly generate [`0aa53db`](https://github.com/DannyBen/bashly/commit/0aa53db)
- Fix --wrap func generation excess newlines [`0a262c6`](https://github.com/DannyBen/bashly/commit/0a262c6)
- Add support for a custom script header [`8899d7c`](https://github.com/DannyBen/bashly/commit/8899d7c)
- Improve friendly error on bash 3 [`7c20a40`](https://github.com/DannyBen/bashly/commit/7c20a40)
- Compare [`v0.6.7..v0.6.8`](https://github.com/dannyben/bashly/compare/v0.6.7..v0.6.8)


v0.6.7 - 2021-09-27
----------------------------------------

- Fix config library context contamination [`58c6525`](https://github.com/DannyBen/bashly/commit/58c6525)
- Compare [`v0.6.6..v0.6.7`](https://github.com/dannyben/bashly/compare/v0.6.6..v0.6.7)


v0.6.6 - 2021-09-07
----------------------------------------

- Add support for -abc, -a=arg and --flag=arg [`6a57c72`](https://github.com/DannyBen/bashly/commit/6a57c72)
- Sort lib files to ensure consistent inclusion [`1e64bfe`](https://github.com/DannyBen/bashly/commit/1e64bfe)
- Compare [`v0.6.5..v0.6.6`](https://github.com/dannyben/bashly/compare/v0.6.5..v0.6.6)


v0.6.5 - 2021-09-03
----------------------------------------

- Upgrade completely gem to allow completions for local scripts [`d8fd173`](https://github.com/DannyBen/bashly/commit/d8fd173)
- Compare [`v0.6.4..v0.6.5`](https://github.com/dannyben/bashly/compare/v0.6.4..v0.6.5)


v0.6.4 - 2021-08-27
----------------------------------------

- Exit with zero on --help [`7ba21b6`](https://github.com/DannyBen/bashly/commit/7ba21b6)
- Add support for required catch_all arguments [`6f34e27`](https://github.com/DannyBen/bashly/commit/6f34e27)
- Compare [`v0.6.3..v0.6.4`](https://github.com/dannyben/bashly/compare/v0.6.3..v0.6.4)


v0.6.3 - 2021-08-25
----------------------------------------

- Exit gracefully if bash version is < 4 [`8b442a8`](https://github.com/DannyBen/bashly/commit/8b442a8)
- Compare [`v0.6.2..v0.6.3`](https://github.com/dannyben/bashly/compare/v0.6.2..v0.6.3)


v0.6.2 - 2021-07-27
----------------------------------------

- Add default option for environment variables [`a320ae8`](https://github.com/DannyBen/bashly/commit/a320ae8)
- Compare [`v0.6.1..v0.6.2`](https://github.com/dannyben/bashly/compare/v0.6.1..v0.6.2)


v0.6.1 - 2021-07-21
----------------------------------------

- Refactor completions to allow adding custom functions (like git branches) [`86cc50a`](https://github.com/DannyBen/bashly/commit/86cc50a)
- Compare [`v0.6.0..v0.6.1`](https://github.com/dannyben/bashly/compare/v0.6.0..v0.6.1)


v0.6.0 - 2021-07-21
----------------------------------------

- Add bash completion generation [`6708dd2`](https://github.com/DannyBen/bashly/commit/6708dd2)
- Compare [`v0.5.1..v0.6.0`](https://github.com/dannyben/bashly/compare/v0.5.1..v0.6.0)


v0.5.1 - 2021-07-02
----------------------------------------

- Add support for a custom help footer [`7512be5`](https://github.com/DannyBen/bashly/commit/7512be5)
- Compare [`v0.5.0..v0.5.1`](https://github.com/dannyben/bashly/compare/v0.5.0..v0.5.1)


v0.5.0 - 2021-06-30
----------------------------------------

- Add support for extensible commands [`8edef13`](https://github.com/DannyBen/bashly/commit/8edef13)
- Compare [`v0.4.5..v0.5.0`](https://github.com/dannyben/bashly/compare/v0.4.5..v0.5.0)


v0.4.5 - 2021-06-24
----------------------------------------

- Avoid wrapping uninterrupted strings [`cd18368`](https://github.com/DannyBen/bashly/commit/cd18368)
- Compare [`v0.4.4..v0.4.5`](https://github.com/dannyben/bashly/compare/v0.4.4..v0.4.5)


v0.4.4 - 2021-06-01
----------------------------------------

- Fix catch all help when no args are used [`715a7f4`](https://github.com/DannyBen/bashly/commit/715a7f4)
- Compare [`v0.4.3..v0.4.4`](https://github.com/dannyben/bashly/compare/v0.4.3..v0.4.4)


v0.4.3 - 2021-05-08
----------------------------------------

- Add ability to catch arbitrary args and flags [`9e7800b`](https://github.com/DannyBen/bashly/commit/9e7800b)
- Compare [`v0.4.2..v0.4.3`](https://github.com/dannyben/bashly/compare/v0.4.2..v0.4.3)


v0.4.2 - 2021-03-04
----------------------------------------

- Remove unused code for --version and --help in root command [`a7012e2`](https://github.com/DannyBen/bashly/commit/a7012e2)
- Add support for allowed values for flags [`39a978e`](https://github.com/DannyBen/bashly/commit/39a978e)
- Add support for whitelist in args [`0b915a4`](https://github.com/DannyBen/bashly/commit/0b915a4)
- Compare [`v0.4.1..v0.4.2`](https://github.com/dannyben/bashly/compare/v0.4.1..v0.4.2)


v0.4.1 - 2021-02-20
----------------------------------------

- Add generate --wrap FUNCTION_NAME option to generate sourcing-friendly output [`e784362`](https://github.com/DannyBen/bashly/commit/e784362)
- Compare [`v0.4.1rc1..v0.4.1`](https://github.com/dannyben/bashly/compare/v0.4.1rc1..v0.4.1)


v0.4.1rc1 - 2021-02-18
----------------------------------------

- Change flag arguments (--flag ARG) to allow argument that starts with a dash [`f4e680d`](https://github.com/DannyBen/bashly/commit/f4e680d)
- Compare [`v0.4.0..v0.4.1rc1`](https://github.com/dannyben/bashly/compare/v0.4.0..v0.4.1rc1)


v0.4.0 - 2020-10-21
----------------------------------------

- Allow using short name only for flags and change '%{long}' in flag translation to '%{name}' [`0523fa8`](https://github.com/DannyBen/bashly/commit/0523fa8)
- Compare [`v0.3.9..v0.4.0`](https://github.com/dannyben/bashly/compare/v0.3.9..v0.4.0)


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
