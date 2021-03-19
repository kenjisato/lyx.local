source etc/util.sh
if verify_cfg etc/config; then
  source etc/config
else
  exit 1
fi

current=$(pwd)
cd "$UserDir"
"$Python" "$LyXDir/configure.py"
cd "$current"
