# ---
# Color functions
# This file is a part of Bashly standard library
#
# Usage:
# Use any of the functions below to color or format a portion of a string.
# 
#   echo "before $(red this is red) after"
#   echo "before $(green_bold this is green_bold) after"
#
# ---

red() { printf "\e[31m%b\e[0m\n" "$*"; }
green() { printf "\e[32m%b\e[0m\n" "$*"; }
yellow() { printf "\e[33m%b\e[0m\n" "$*"; }
blue() { printf "\e[34m%b\e[0m\n" "$*"; }
magenta() { printf "\e[35m%b\e[0m\n" "$*"; }
cyan() { printf "\e[36m%b\e[0m\n" "$*"; }
bold() { printf "\e[1m%b\e[0m\n" "$*"; }
underlined() { printf "\e[4m%b\e[0m\n" "$*"; }
red_bold() { printf "\e[1;31m%b\e[0m\n" "$*"; }
green_bold() { printf "\e[1;32m%b\e[0m\n" "$*"; }
yellow_bold() { printf "\e[1;33m%b\e[0m\n" "$*"; }
blue_bold() { printf "\e[1;34m%b\e[0m\n" "$*"; }
magenta_bold() { printf "\e[1;35m%b\e[0m\n" "$*"; }
cyan_bold() { printf "\e[1;36m%b\e[0m\n" "$*"; }
red_underlined() { printf "\e[4;31m%b\e[0m\n" "$*"; }
green_underlined() { printf "\e[4;32m%b\e[0m\n" "$*"; }
yellow_underlined() { printf "\e[4;33m%b\e[0m\n" "$*"; }
blue_underlined() { printf "\e[4;34m%b\e[0m\n" "$*"; }
magenta_underlined() { printf "\e[4;35m%b\e[0m\n" "$*"; }
cyan_underlined() { printf "\e[4;36m%b\e[0m\n" "$*"; }
