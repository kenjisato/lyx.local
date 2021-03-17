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

is_newer() {
  if [ $# -ne 2 ]; then
    echo "Usage: is_newer file1 file2" 1>&2
    exit 1
  fi

  if [ ! -f $1 -o ! -f $2 ]; then
    return 1
  fi

  if [ -n "$(find $1 -newer $2 -print)" ]; then
    return 0
  else
    return 1
  fi
}
