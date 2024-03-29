# bashly completion                                        -*- shell-script -*-

# This bash completions script was generated by
# completely (https://github.com/dannyben/completely)
# Modifying it manually is not recommended

_bashly_completions_filter() {
  local words="$1"
  local cur=${COMP_WORDS[COMP_CWORD]}
  local result=()

  if [[ "${cur:0:1}" == "-" ]]; then
    echo "$words"
  
  else
    for word in $words; do
      [[ "${word:0:1}" != "-" ]] && result+=("$word")
    done

    echo "${result[*]}"

  fi
}

_bashly_completions() {
  local cur=${COMP_WORDS[COMP_CWORD]}
  local compwords=("${COMP_WORDS[@]:1:$COMP_CWORD-1}")
  local compline="${compwords[*]}"

  case "$compline" in
    'generate'*'--env')
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_bashly_completions_filter "development production")" -- "$cur" )
      ;;

    'generate'*'-e')
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_bashly_completions_filter "development production")" -- "$cur" )
      ;;

    'completions'*)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_bashly_completions_filter "--help -h --install -i")" -- "$cur" )
      ;;

    'validate'*)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_bashly_completions_filter "--help -h --verbose -v")" -- "$cur" )
      ;;

    'generate'*)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_bashly_completions_filter "--help -h --env --force --quiet --upgrade --watch --wrap -e -f -q -r -u -w")" -- "$cur" )
      ;;

    'preview'*)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_bashly_completions_filter "--help -h")" -- "$cur" )
      ;;

    'g'*'--env')
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_bashly_completions_filter "development production")" -- "$cur" )
      ;;

    'shell'*)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_bashly_completions_filter "--help -h")" -- "$cur" )
      ;;

    'init'*)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_bashly_completions_filter "--help -h --minimal -m")" -- "$cur" )
      ;;

    'g'*'-e')
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_bashly_completions_filter "development production")" -- "$cur" )
      ;;

    'add'*)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_bashly_completions_filter "--help -h --force --list --source -f -l -s colors completions completions_script completions_yaml config help hooks lib settings strings test validations yaml")" -- "$cur" )
      ;;

    'doc'*)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_bashly_completions_filter "--help -h --index -i arg arg.allowed arg.default arg.help arg.name arg.repeatable arg.required arg.validate command command.alias command.args command.catch_all command.commands command.completions command.default command.dependencies command.environment_variables command.examples command.expose command.extensible command.filename command.filters command.flags command.footer command.function command.group command.help command.name command.private command.version environment_variable environment_variable.default environment_variable.help environment_variable.name environment_variable.private environment_variable.required flag flag.allowed flag.arg flag.completions flag.conflicts flag.default flag.help flag.long flag.private flag.repeatable flag.required flag.short flag.validate")" -- "$cur" )
      ;;

    'i'*)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_bashly_completions_filter "--help -h --minimal -m")" -- "$cur" )
      ;;

    'p'*)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_bashly_completions_filter "--help -h")" -- "$cur" )
      ;;

    'v'*)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_bashly_completions_filter "--help -h --verbose -v")" -- "$cur" )
      ;;

    'g'*)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_bashly_completions_filter "--help -h --env --force --quiet --upgrade --watch --wrap -e -f -q -r -u -w")" -- "$cur" )
      ;;

    'a'*)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_bashly_completions_filter "--help -h --force --list --source -f -l -s colors completions completions_script completions_yaml config help hooks lib settings strings test validations yaml")" -- "$cur" )
      ;;

    'c'*)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_bashly_completions_filter "--help -h --install -i")" -- "$cur" )
      ;;

    's'*)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_bashly_completions_filter "--help -h")" -- "$cur" )
      ;;

    *)
      while read -r; do COMPREPLY+=( "$REPLY" ); done < <( compgen -W "$(_bashly_completions_filter "--help -h --version -v init preview validate generate add doc completions shell")" -- "$cur" )
      ;;

  esac
} &&
complete -F _bashly_completions bashly

# ex: filetype=sh
