#!/usr/bin/env bash

# shellcheck disable=SC2155

success=0
fail=1

reset='\e[0m'
red='\e[31m'
background_red='\e[41m'

error() {
    local in_message="$1"
    printf "${background_red}error:$reset$red %s$reset" "$in_message" >&2
    exit "$fail"
}

error_when_option_is_not_supported() {
    local in_option="$1"
    error "'$in_option' is not supported."
}

error_when_dependency_does_not_exist() {
    local in_dependency="$1"
    local in_command="$2"

    ! which "$in_dependency" > /dev/null && {
        error "'$in_dependency' dependency doesn't exist, to install it use '$in_command'."
    }
}

help() {
  echo "Generates bashly.yml interactively through interactive questions.

Usage:
  $0 [--help|-h] [--version|-v]

Options:
  --help|-h     Print help.
  --version|-v  Print version."
  exit "$success"
}

version() {
  echo '1.0.0'
  exit "$success"
}

gum_input() {
    local in_prompt="$1"
    local in_error_prompt="$2"
    local in_valid_regex="$3"
    local in_placeholder="$4"
    
    local value="$(gum input --prompt "$in_prompt" --placeholder="$in_placeholder")"
    
    while [[ ! "$value" =~ $in_valid_regex ]]; do
        value="$(gum input --prompt="$in_error_prompt" --placeholder="$in_placeholder" --prompt.foreground='#F00')"
    done

    echo "$value"
}

new_flag() {
    local short_flag="$(gum_input 'Short flag name: ' \
        'Short flag name (<one character>): ' \
        '^.$' \
        'Type flag name without a leading dash...')"
    local long_flag="$(gum_input 'Long flag name: ' \
        'Long flag name (<non empty string>): ' \
        '.' \
        'Type flag name without two leading dashes...')"
    local flags="'-$short_flag'/'--$long_flag'"
    local help="$(gum_input "$flags description: " "$flags description (<non empty string>): " '.')"
    local is_required=false
    gum confirm "Do you want to make $flags required?" &&
        is_required=true

    jq -n -M \
        '{
            short: $ARGS.named["short"],
            long: $ARGS.named["long"],
            help: $ARGS.named["help"],
            required: ($ARGS.named["required"] == "true")
        }' \
        --arg short "-$short_flag" \
        --arg long "--$long_flag" \
        --arg help "$help" \
        --arg required "$is_required"
}

new_config() {
    local in_name="$1"
    local in_help="$2"
    local in_version="$3"
    local in_flags="$flags"

    local header_json="$(jq -n \
        '{
            name: $ARGS.named["name"],
            help: $ARGS.named["help"],
            version: $ARGS.named["version"]
        }' \
        --arg name "$in_name" \
        --arg help "$in_help" \
        --arg version "$in_version")"
    
    local flag_json="$(jq -n \
        '{
            args: $ARGS.named["flags"]
        }' \
        --argjson flags "$in_flags")"


    jq -n '$ARGS.named["header"] + $ARGS.named["flags"]' \
        --argjson header "$header_json" \
        --argjson flags "$flag_json" |
        dv --yaml
}

save_config() {
    local in_name="$1"
    local in_help="$2"
    local in_version="$3"
    local in_flags="$4"

    local config_path=""
    while [[ -z "$config_path" ]] || [[ ! -d "$(dirname "$config_path")" ]]; do
        config_path="$(gum_input 'Config path: ' \
            'Config path (<existing path>): ' '.')"
    done
    new_config "$in_name" "$in_help" "$in_version" "$in_flags" > "$config_path"
}

interactive() {
    export GUM_INPUT_CURSOR_FOREGROUND='#FF0'
    export GUM_INPUT_PROMPT_FOREGROUND='#0FF'

    local name="$(gum_input 'Application name: ' \
        'Application name (<non empty string>): ' '.')"
    local version="$(gum_input 'Application semantic version: ' \
        'Application semantic version (<major>.<minor>.<patch>): ' \
        '^[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+$' '1.42.3')"
    local help="$(gum_input 'Application description: ' \
        'Application description (<non empty string>): ' \
        '.')"

    local flags='[]'

    if gum confirm 'Do you want add flags?'; then
        local action

        while true; do
            action="$(printf '%s\n' \
                'Add flag' \
                'Remove flag' \
                'Preview config' \
                'Finish creating config' |
                gum choose)"

            case "$action" in
                Add*)
                    flags="$(jq -n '$ARGS.named["flags"] + [$ARGS.named["flag"]]' \
                        --argjson flag "$(new_flag)"\
                        --argjson flags "$flags")"
                    ;;
                Remove*)
                    local no_flags="$(echo "$flags" | jq -r '. == []')"
                    [[ "$no_flags" == true ]] && {
                        echo "No flags to remove."
                        continue
                    }
                    local flag="$(echo "$flags" |
                        jq -r ".[].long" |
                        gum choose)"
                    
                    flags="$(echo "$flags" |
                        jq '.[] | select(.long != $ARGS.named["flag"])' \
                        --arg flag "$flag")"
                    ;;
                Preview*)
                    new_config "$name" "$help" "$version" "$flags" |
                        batcat --language=yaml --paging=always
                    ;;
                Finish*)
                    save_config "$name" "$help" "$version" "$flags"
                    exit
                    ;;
            esac
        done
    fi

    save_config "$name" "$help" "$version" "$flags"
}

option="$1"
case "$option" in
    --help|-h)
        help
        ;;
    --version|-v)
        version
        ;;
    -*)
        error_when_option_is_not_supported "$option"
        ;;
esac

error_when_dependency_does_not_exist gum 'go install github.com/charmbracelet/gum@latest'
error_when_dependency_does_not_exist dv 'gem install --user-install dupervisor'
error_when_dependency_does_not_exist batcat 'sudo apt install bat'
interactive
