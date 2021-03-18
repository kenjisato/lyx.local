source etc/config
source etc/util.sh

configure=false
current=$(pwd)
cd LyX

for f in layouts/*
do
  [ -e "$f" ] || continue
  python "$LyXDir/scripts/layout2layout.py" $f $f.temp

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
  echo You must run "make deploy reconfigure" to deploy and then to let LyX know the changes.
else
  echo Nothing to upgrade.
fi
