# ---
# Color functions
# This file is a part of Bashly standard library
#
# Usage:
# Use any of the functions below to color or format a portion of a string.
# 
#  echo "before $(red this is red) after"
#  echo "before $(green_bold this is green_bold) after"
#
# ---

red() { echo -e "\e[31m$*\e[0m" ; }
green() { echo -e "\e[32m$*\e[0m" ; }
yellow() { echo -e "\e[33m$*\e[0m" ; }
blue() { echo -e "\e[34m$*\e[0m" ; }
magenta() { echo -e "\e[35m$*\e[0m" ; }
cyan() { echo -e "\e[36m$*\e[0m" ; }
bold() { echo -e "\e[1m$*\e[0m" ; }
underlined() { echo -e "\e[4m$*\e[0m" ; }
red_bold() { echo -e "\e[1;31m$*\e[0m" ; }
green_bold() { echo -e "\e[1;32m$*\e[0m" ; }
yellow_bold() { echo -e "\e[1;33m$*\e[0m" ; }
blue_bold() { echo -e "\e[1;34m$*\e[0m" ; }
magenta_bold() { echo -e "\e[1;35m$*\e[0m" ; }
cyan_bold() { echo -e "\e[1;36m$*\e[0m" ; }
red_underlined() { echo -e "\e[4;31m$*\e[0m" ; }
green_underlined() { echo -e "\e[4;32m$*\e[0m" ; }
yellow_underlined() { echo -e "\e[4;33m$*\e[0m" ; }
blue_underlined() { echo -e "\e[4;34m$*\e[0m" ; }
magenta_underlined() { echo -e "\e[4;35m$*\e[0m" ; }
cyan_underlined() { echo -e "\e[4;36m$*\e[0m" ; }
