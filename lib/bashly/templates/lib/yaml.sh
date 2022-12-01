## YAML parser [@bashly-upgrade yaml]
## This file is a part of Bashly standard library
## Does not support arrays, only hashes
##
## Source: https://stackoverflow.com/a/21189044/413924
##
## Usage:
##
##   yaml_load "settings.yml"             # print variables
##   yaml_load "settings.yml" "config_"   # use prefix
##   eval $(yaml_load "settings.yml")     # create variables in scope
##
yaml_load() {
  local prefix=$2
  local s='[[:space:]]*' w='[a-zA-Z0-9_]*'
  local fs

  fs=$(echo @ | tr @ '\034')

  sed -ne "s|^\($s\):|\1|" \
    -e "s|^\($s\)\($w\)$s:${s}[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
    -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p" "$1" |
    awk -F"$fs" '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'"$prefix"'",vn, $2, $3);
      }
    }'
}