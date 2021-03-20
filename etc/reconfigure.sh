source etc/util.sh
source etc/verify.sh

if verify_cfg etc/config; then
  source etc/config
else
  warn "'etc/config' does not exist. Run "
  warn
  warn "     make init "
  exit 1
fi

current=$(pwd)
cd "$UserDir"
# Path fixation for WSL and Cygwin
LyXDirFix=$(fix_windir "$LyXDir")
"$Python" "$LyXDirFix/configure.py"
cd "$current"
