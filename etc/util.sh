warn() {
  echo $(tput setaf 9)$@$(tput sgr0)
}

praise() {
  echo $(tput setaf 2)$@$(tput sgr0)
}


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

get_platform() {
  local platform
  local kernel_name="$(uname -s)"
  local kernel_release="$(uname -r)"

  case "${kernel_name}" in
    Linux*)     platform=linux;;
    Darwin*)    platform=mac;;
    CYGWIN*)    platform=cygwin;;
    MINGW*)     platform=msys;;
    MSYS*)      platform=msys;;
    *)          platform=unknown;;
  esac

  case "${kernel_release}" in
    *microsoft*)  platform=wsl;;
    *)            ;;
  esac

  echo $platform
}

fix_windir() {
  local fixed_path
  local input="$@"
  case $(get_platform) in
    wsl*)     fixed_path=$(echo $input | sed "s%^/mnt/c%C:%" ) ;;
    cygwin*)  fixed_path=$(echo $input | sed "s%^/cygdrive/c%C:%" ) ;;
    *)        fixed_path=$(echo $input ) ;;
  esac
  echo $fixed_path
}
