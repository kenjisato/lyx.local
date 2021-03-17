source etc/config
source etc/util.sh

configure=false
current=$(pwd)
cd LyX

for d in ${directories[@]}
do
  for from in $d/*
  do
    [ -e "$from" ] || continue
    if is_in "$from" "${exclude[@]}"; then
      continue
    fi
    dest=$UserDir/$from
    if [ -e "$dest" ]; then
      if is_newer "$dest" "$from"; then
        continue
      fi

      if is_in "$from" "${require_backup[@]}"; then
        dt=$(date "+%Y%m%d.%H%M%S")
        cp $dest $dest-$dt
        echo backup created: $dest-$dt
      fi
    fi
    cp $from $dest
    configure=true
  done
done

if "$configure"; then
  cd $UserDirs
  python $LyXDir/configure.py
else
  echo Nothing to deploy.
fi
cd $current
