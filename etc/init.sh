source etc/util.sh

cfg=etc/config

if [ -e "$cfg" ]; then
  echo \'etc/config\' already exists. Abort the operation.
  echo If you need to change configurations, please delete or manually edit it.
  exit 1
fi

linux_init() {
  echo Python="$(which python)" > $cfg
  echo LyX=/usr/bin/lyx >> $cfg
  echo LyXDir=/usr/share/lyx >> $cfg
  echo UserDir=${Home}/.lyx >> $cfg
}

mac_init() {
  path_prefix="${HOME}/Library/Application Support/LyX-"
  VERSION=$(find_latest_version "$path_prefix")
  echo Python="$(which python)" > $cfg
  echo LyX=/Applications/LyX.app/Contents/MacOS/lyx >> $cfg
  echo LyXDir=/Applications/LyX.app/Contents/Resources >> $cfg
  echo UserDir=\"${HOME}/Library/Application Support/LyX-${VERSION}\" >> $cfg
}

msys_init() {
  path_prexif="/c/Users/${USER}/AppData/Roaming/LyX"
  VERSION=$(find_latest_version "$path_prefix")
  echo Python="/c/Program Files/LyX $VERSION/python/python.exe"
  echo LyX="/c/Program Files/LyX $VERSION/bin/LyX.exe"
  echo LyXDir="/c/Program Files/LyX $VERSION/Resources"
  echo UserDir="/c/Users/${USER}/AppData/Roaming/LyX$VERSION"
}

cygwin_init() {
  path_prexif="/cygdrive/c/Users/${USER}/AppData/Roaming/LyX"
  VERSION=$(find_latest_version "$path_prefix")
  echo Python="/cygdrive/c/Program Files/LyX $VERSION/python/python.exe"
  echo LyX="/cygdrive/c/Program Files/LyX $VERSION/bin/LyX.exe"
  echo LyXDir="/cygdrive/c/Program Files/LyX $VERSION/Resources"
  echo UserDir="/cygdrive/c/Users/${USER}/AppData/Roaming/LyX$VERSION"
}

wsl_init() {
  win_user=$(echo $(powershell.exe '$env:UserName') | sed "s%\r%%g")
  path_prexif="/mnt/c/Users/${win_user}/AppData/Roaming/LyX"
  VERSION=$(find_latest_version "$path_prefix")
  echo Python="/mnt/c/Program Files/LyX $VERSION/python/python.exe"
  echo LyX="/mnt/c/Program Files/LyX $VERSION/bin/LyX.exe"
  echo LyXDir="/mnt/c/Program Files/LyX $VERSION/Resources"
  echo UserDir="/mnt/c/Users/${win_user}/AppData/Roaming/LyX$VERSION"
}

unknown_init() {
  echo Python=
  echo LyX=
  echo LyXDir=
  echo UserDir
  echo
  echo I don\'t know what to do. Please manually edit \'etc/config\'!
}

kernel_name="$(uname -s)"
kernel_release="$(uname -r)"

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

case "$platform" in
  linux*)   linux_init;;
  mac*)     mac_init;;
  msys*)    msys_init;;
  cygwin*)  cygwin_init;;
  wsl*)     wsl_init;;
  unknown*) unknown_init;;
  *)        ;;
esac

verify_cfg "$cfg"
