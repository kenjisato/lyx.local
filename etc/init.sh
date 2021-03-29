source etc/util.sh
source etc/verify.sh

cfg=etc/config

if [ -e "$cfg" ]; then
  warn "'etc/config' already exists. Abort the operation."
  warn "If you need to change configurations, please delete or manually edit the file."
  exit 0
fi

linux_init() {
  local Python="$(which python)"
  [ -z "$Python" ] && Python="$(which python3)"
  echo Python="$Python" > $cfg
  echo LyX=/usr/bin/lyx >> $cfg
  echo LyXDir=/usr/share/lyx >> $cfg
  echo UserDir=${HOME}/.lyx >> $cfg
  if ! command -v kpsewhich &> /dev/null; then
    echo TexMfHome= >> $cfg
  else
    echo TexMfHome=$(kpsewhich -var-value TEXMFHOME) >> $cfg
  fi
}

mac_init() {
  path_prefix="${HOME}/Library/Application Support/LyX-"
  VERSION=$(find_latest_version "$path_prefix")
  echo Python="$(which python)" > $cfg
  echo LyX=/Applications/LyX.app/Contents/MacOS/lyx >> $cfg
  echo LyXDir=/Applications/LyX.app/Contents/Resources >> $cfg
  echo UserDir=\"${HOME}/Library/Application Support/LyX-${VERSION}\" >> $cfg
  if ! command -v kpsewhich &> /dev/null; then
    echo TexMfHome= >> $cfg
  else
    echo TexMfHome=$(kpsewhich -var-value TEXMFHOME) >> $cfg
  fi
}

msys_init() {
  path_prefix="/c/Users/${USER}/AppData/Roaming/LyX"
  VERSION=$(find_latest_version "$path_prefix")
  echo Python=\"/c/Program Files/LyX $VERSION/python/python.exe\" > $cfg
  echo LyX=\"/c/Program Files/LyX $VERSION/bin/LyX.exe\" >> $cfg
  echo LyXDir=\"/c/Program Files/LyX $VERSION/Resources\" >> $cfg
  echo UserDir=\"/c/Users/${USER}/AppData/Roaming/LyX$VERSION\" >> $cfg
}

cygwin_init() {
  path_prefix="/cygdrive/c/Users/${USER}/AppData/Roaming/LyX"
  VERSION=$(find_latest_version "$path_prefix") > $cfg
  echo Python=\"/cygdrive/c/Program Files/LyX $VERSION/python/python.exe\" >> $cfg
  echo LyX=\"/cygdrive/c/Program Files/LyX $VERSION/bin/LyX.exe\" >> $cfg
  echo LyXDir=\"/cygdrive/c/Program Files/LyX $VERSION/Resources\" >> $cfg
  echo UserDir=\"/cygdrive/c/Users/${USER}/AppData/Roaming/LyX$VERSION\" >> $cfg
}

wsl_init() {
  win_user=$(powershell.exe '$env:UserName')
  win_user=$(echo $win_user | sed "s%\r%%g")
  path_prefix="/mnt/c/Users/${win_user}/AppData/Roaming/LyX"
  VERSION=$(find_latest_version "$path_prefix")
  echo Python=\"/mnt/c/Program Files/LyX $VERSION/python/python.exe\" > $cfg
  echo LyX=\"/mnt/c/Program Files/LyX $VERSION/bin/LyX.exe\" >> $cfg
  echo LyXDir=\"/mnt/c/Program Files/LyX $VERSION/Resources\" >> $cfg
  echo UserDir=\"/mnt/c/Users/${win_user}/AppData/Roaming/LyX$VERSION\" >> $cfg
}

unknown_init() {
  echo Python= > $cfg
  echo LyX= >> $cfg
  echo LyXDir= >> $cfg
  echo UserDir= >> $cfg
  echo
  warn "I don't know what to do. Please manually edit 'etc/config'!"
}

case "$(get_platform)" in
  linux*)   linux_init;;
  mac*)     mac_init;;
  msys*)    msys_init;;
  cygwin*)  cygwin_init;;
  wsl*)     wsl_init;;
  unknown*) unknown_init;;
  *)        ;;
esac

verify_cfg "$cfg"
