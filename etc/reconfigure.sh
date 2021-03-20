source etc/util.sh
if verify_cfg etc/config; then
  source etc/config
else
  exit 1
fi

current=$(pwd)
cd "$UserDir"
# Path fixation for WSL
LyXDirFix=$(echo "$LyXDir" | sed "s%^/mnt/c%C:%" )
"$Python" "$LyXDirFix/configure.py"
cd "$current"
