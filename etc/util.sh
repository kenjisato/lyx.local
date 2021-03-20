is_in() {
  local element="$1"
  shift
  local arr=("$@")
  for i in "${arr[@]}"
  do
    case $element in
      $i) return 0 ;;
      *) ;;
    esac
  done
  return 1
}

is_newer() {
  if [ $# -ne 2 ]; then
    echo "Usage: is_newer file1 file2" 1>&2
    exit 1
  fi

  if [ ! -f "$1" -o ! -f "$2" ]; then
    return 1
  fi

  if [ -n "$(find \"$1\" -newer \"$2\" -print)" ]; then
    return 0
  else
    return 1
  fi
}

find_latest_version() {
  path_prefix="$1"
  echo "$path_prefix"* | \
    sed "s%$path_prefix%%g" |\
    sed "s/ /\n/g" | \
    sort -t '.' -k 1,1 -k 2,2 -g -r | \
    sed -n -e '1p'
}

verify_cfg() {
  if [ ! -e "$1" ]; then
    echo "$1" does not exist.
    return 1
  fi
  python_required=('2.7.*' '3.5.*' '3.6.*' '3.7.*' '3.8.*' '3.9.*')
  lyxdir_needs=configure.py
  userdir_needs=configure.log

  source "$1"
  success=true
  
  if [ ! -e "$Python" ]; then
    echo ✗ Python: FATAL! I cannot find Python.
    success=false
  else
    python_version=$("$Python" -c "import platform; print(platform.python_version())")
    if is_in "$python_version" "${python_required[@]}"; then
      echo ✔ Python: version is $python_version.
    else
      echo ✗  Python: WARNING! Python 2 \> 2.7 or 3 \> 3.5 is expected. You have $python_version.
      success=false
    fi
  fi

  if [ -e "$LyXDir/$lyxdir_needs" ]; then
    echo ✔ LyXDir: contains \'$lyxdir_needs\'.
  else
    echo ✗ LyXDir: FATAL! Your \<LyXDir\> does not contain \'$lyxdir_needs\'.
    succes=false
  fi

  if [ -e "$UserDir"/"$userdir_needs" ]; then
    echo ✔ UserDir: contains \'$userdir_needs\'.
  else
    echo ✗ UserDir: WARNING! Your \<UserDir\> does not contain \'"$userdir_needs"\'.
    echo "    I am not sure whether your configurations are intentional."
    echo "    Running '$userdir_needs' in the <UserDir> you specify could end up with"
    echo "    a VERY unpleasant situation. So, I do not proceed. If you think this"
    echo "    is the right place, please run LyX in there before using my scripts."
    success=false
  fi
  if "${success}"; then
    return 0
  else
    echo Sorry, config verication failed. Please manually edit 'etc/config'.
    echo "   Python .... path to Python 2.7.x"
    echo "   LyX    .... path to LyX application"
    echo "   LyXDir .... path to LyX's system directory"
    echo "   UserDir.... path to LyX's user directory"
    return 1
  fi
}
