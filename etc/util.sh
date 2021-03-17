is_in() {
  local element="$1"
  shift
  local arr=("$@")
  for i in "${arr[@]}"
  do
    [[ "$element" == "$i" ]] && return 0
  done
  return 1
}
