sort_array() {
  local input=("$@")
  IFS=$'\n' sorted=($(sort <<<"${input[*]}"))
  echo "${sorted[@]}"
}