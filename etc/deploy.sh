source etc/util.sh
if verify_cfg etc/config; then
  source etc/config
else
  exit 1
fi
source etc/deploy_targets
source etc/deploy_targets.local

configure=false
current=$(pwd)
cd LyX

for d in "${directories[@]}"
do
  echo "$d/"
  for from in $d/*
  do
    [ -e "$from" ] || continue
    if is_in "$from" "${exclude[@]}"; then
      echo ..... Skipping "$from" : List \'exclude\' contains it.
      continue
    fi
    dest="$UserDir/$from"
    if [ -e "$dest" ]; then
      newfile=$(find "$dest" -newer $from -print)
      if [ -n "$newfile" ]; then
        echo ..... Skipping "$from" : File in UserDir is newer.
        continue
      fi

      if is_in "$from" "${require_backup[@]}"; then
        dt=$(date "+%Y%m%d.%H%M%S")
        cp "$dest" "$dest-$dt"
        echo backup created: "$dest-$dt"
      fi
    fi
    cp "$from" "$dest"
    echo ..... Deploy "$from"
    configure=true
  done
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
  echo Nothing to deploy.
  echo
fi
