source etc/config
source etc/util.sh

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
    if [ -e "$dest" ] && is_in "$from" "${require_backup[@]}"; then
      dt=$(date "+%Y%m%d.%H%M%S")
      cp $dest $dest-$dt
      echo backup created: $dest-$dt
    fi
    cp $from $dest
  done
done

cd $UserDirs
python $LyXDir/configure.py
cd current
