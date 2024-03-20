# approvals.bash v0.5.1
#
# Interactive approval testing for Bash.
# https://github.com/DannyBen/approvals.bash
#
# shellcheck disable=SC2059
# Disabling SC2059 (quoted format string) because we use dynamic format strings
approve() {
  local expected approval approval_file actual cmd
  approvals_dir=${APPROVALS_DIR:=approvals}

  cmd=$1
  last_exit_code=0
  actual=$(eval "$cmd" 2>&1) || last_exit_code=$?
  if [[ -v allow_diff_regex && "$allow_diff_regex" ]]; then
    actual=$(echo "$actual" | sed -E "s/$allow_diff_regex/*/g")
    unset allow_diff_regex
  fi
  approval=$(printf "%b" "$cmd" | tr -s -c "[:alnum:]" _)
  approval_file="$approvals_dir/${2:-"$approval"}"

  [[ -d "$approvals_dir" ]] || mkdir "$approvals_dir"

  if [[ -f "$approval_file" ]]; then
    expected=$(cat "$approval_file")
  else
    printf -- "$new_diff_string\n" "$cmd"
    printf "%b\n" "$actual"
    printf -- "$new_diff_string\n" "$cmd"
    expected="$actual"
    user_approval "$cmd" "$actual" "$approval_file"
    return
  fi

  if [[ "$(printf "%b" "$actual")" = "$(printf "%b" "$expected")" ]]; then
    pass "$cmd"
  else
    printf -- "$changed_diff_string\n" "$cmd"
    $diff_cmd <(printf "%b" "$expected\n") <(printf "%b" "$actual\n") | tail -n +4
    printf -- "$changed_diff_string\n" "$cmd"
    user_approval "$cmd" "$actual" "$approval_file"
  fi
}

allow_diff() {
  allow_diff_regex="$1"
}

describe() {
  printf "$describe_string\n" "$*"
}

context() {
  printf "$context_string\n" "$*"
}

it() {
  printf "$it_string\n" "$*"
}

fail() {
  printf "$fail_string\n" "$*"
  exit 1
}

pass() {
  printf "$pass_string\n" "$*"
  return 0
}

expect_exit_code() {
  if [[ $last_exit_code == "$1" ]]; then
    pass "exit $last_exit_code"
  else
    fail "expected exit code $1, got $last_exit_code"
  fi
}

# Private

print_in_color() {
  local color="$1"
  shift
  if [[ -z ${NO_COLOR+x} ]]; then
    printf "$color%b\e[0m\n" "$*"
  else
    printf "%b\n" "$*"
  fi
}

red() { print_in_color "\e[31m" "$*"; }
green() { print_in_color "\e[32m" "$*"; }
yellow() { print_in_color "\e[33m" "$*"; }
blue() { print_in_color "\e[34m" "$*"; }
magenta() { print_in_color "\e[35m" "$*"; }
cyan() { print_in_color "\e[36m" "$*"; }
bold() { print_in_color "\e[1m" "$*"; }
underlined() { print_in_color "\e[4m" "$*"; }
red_bold() { print_in_color "\e[1;31m" "$*"; }
green_bold() { print_in_color "\e[1;32m" "$*"; }
yellow_bold() { print_in_color "\e[1;33m" "$*"; }
blue_bold() { print_in_color "\e[1;34m" "$*"; }
magenta_bold() { print_in_color "\e[1;35m" "$*"; }
cyan_bold() { print_in_color "\e[1;36m" "$*"; }
red_underlined() { print_in_color "\e[4;31m" "$*"; }
green_underlined() { print_in_color "\e[4;32m" "$*"; }
yellow_underlined() { print_in_color "\e[4;33m" "$*"; }
blue_underlined() { print_in_color "\e[4;34m" "$*"; }
magenta_underlined() { print_in_color "\e[4;35m" "$*"; }
cyan_underlined() { print_in_color "\e[4;36m" "$*"; }

user_approval() {
  local cmd="$1"
  local actual="$2"
  local approval_file="$3"

  if [[ -v CI || -v GITHUB_ACTIONS ]] && [[ -z "${AUTO_APPROVE+x}" ]]; then
    fail "$cmd"
  fi

  if [[ -v AUTO_APPROVE ]]; then
    response=a
  else
    echo
    printf "$approval_string"
    response=$(bash -c "read -n 1 key; echo \$key")
    printf "\b%.s" $(seq 1 $((${#approval_string} + 1)))
  fi

  if [[ $response =~ [Aa] ]]; then
    printf "%b\n" "$actual" >"$approval_file"
    pass "$cmd"
  else
    fail "$cmd"
  fi
}

onexit() {
  exitcode=$?
  if [[ "$exitcode" == 0 ]]; then
    printf "$exit_success_string\n" "$0"
  else
    printf "$exit_failed_string\n" "$0"
  fi
  echo
  exit $exitcode
}

onerror() {
  fail "caller: $(caller)"
}

set -e
trap 'onexit' EXIT
trap 'onerror' ERR

describe_string="$(bold ▌ describe)   %s"
context_string="$(bold ▌ context)    %s"
it_string="$(bold ▌ it)         %s"
fail_string="  $(red_bold failed)     %s"
pass_string="  $(green approved)   %s"
exit_success_string="$(green ▌ exit)       $(bold %s finished successfully)"
exit_failed_string="$(red_bold ▌ exit)       $(bold %s finished with errors)"
new_diff_string="────┤ $(yellow new): $(bold %s) ├────"
changed_diff_string="────┤ $(blue changed): $(bold %s) ├────"
approval_string="[A]pprove? "

if diff --help | grep -- --color >/dev/null 2>&1; then
  diff_cmd="diff --unified --color=always"
else
  diff_cmd="diff --unified"
fi
