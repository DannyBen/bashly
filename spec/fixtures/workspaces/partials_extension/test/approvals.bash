# approvals.bash v0.3.3
#
# Interactive approval testing for Bash.
# https://github.com/DannyBen/approvals.bash
approve() {
  local expected approval approval_file actual cmd
  approvals_dir=${APPROVALS_DIR:=approvals}

  cmd=$1
  last_exit_code=0
  actual=$(eval "$cmd" 2>&1) || last_exit_code=$?
  approval=$(printf "%b" "$cmd" | tr -s -c "[:alnum:]" _)
  approval_file="$approvals_dir/${2:-"$approval"}"

  [[ -d "$approvals_dir" ]] || mkdir "$approvals_dir"

  if [[ -f "$approval_file" ]]; then
    expected=$(cat "$approval_file")
  else
    echo "--- [$(blue "new: $cmd")] ---"
    printf "%b\n" "$actual"
    echo "--- [$(blue "new: $cmd")] ---"
    expected="$actual"
    user_approval "$cmd" "$actual" "$approval_file"
    return
  fi

  if [[ "$(printf "%b" "$actual")" = "$(printf "%b" "$expected")" ]]; then
    pass "$cmd"
  else
    echo "--- [$(blue "diff: $cmd")] ---"
    $diff_cmd <(printf "%b" "$expected\n") <(printf "%b" "$actual\n") | tail -n +4
    echo "--- [$(blue "diff: $cmd")] ---"
    user_approval "$cmd" "$actual" "$approval_file"
  fi
}

describe() {
  echo
  blue "= $*"
}

context() {
  echo
  magenta "= $*"
}

fail() {
  red "  FAILED: $*"
  exit 1
}

pass() {
  green "  approved: $*"
  return 0
}

expect_exit_code() {
  if [[ $last_exit_code == "$1" ]]; then
    pass "exit $last_exit_code"
  else
    fail "Expected exit code $1, got $last_exit_code"
  fi
}

red() { printf "\e[31m%b\e[0m\n" "$*"; }
green() { printf "\e[32m%b\e[0m\n" "$*"; }
blue() { printf "\e[34m%b\e[0m\n" "$*"; }
magenta() { printf "\e[35m%b\e[0m\n" "$*"; }
cyan() { printf "\e[36m%b\e[0m\n" "$*"; }

# Private

user_approval() {
  local cmd="$1"
  local actual="$2"
  local approval_file="$3"

  if [[ -v CI || -v GITHUB_ACTIONS ]]; then
    fail "$cmd"
  fi

  echo
  printf "[A]pprove? \n"
  response=$(bash -c "read -n 1 key; echo \$key")
  printf "\r"
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
    green "\nFinished successfully"
  else
    red "\nFinished with failures"
  fi
  exit $exitcode
}

onerror() {
  fail "Caller: $(caller)"
}

set -e
trap 'onexit' EXIT
trap 'onerror' ERR

if diff --help | grep -- --color >/dev/null 2>&1; then
  diff_cmd="diff --unified --color=always"
else
  diff_cmd="diff --unified"
fi
