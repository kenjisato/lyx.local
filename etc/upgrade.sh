source etc/util.sh

if [ -e "etc/config" ]; then
  message=$(verify_cfg "etc/config")
  if [ $? -eq 0 ]; then
    source "etc/config"
  else
    echo "$message"
    exit 1
  fi
else
  echo "Error: 'etc/config' does not exist. First, run "
  echo
  echo "    make init"
  echo
  exit 1
fi

configure=false
current=$(pwd)
cd LyX

for f in layouts/*
do
  [ -e "$f" ] || continue
  "$Python" "$LyXDir/scripts/layout2layout.py" $f $f.temp

  diff -s $f $f.temp > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    rm $f.temp
  elif [ $? -eq 1 ]; then
    mv $f.temp $f
    configure=true
  fi
done

cd "$current"
if "$configure"; then
  echo
  echo Next step: To let LyX know the changes, you must run
  echo
  echo "    make reconfigure"
  echo
else
  echo
  echo All files are up to date!
  echo
fi
