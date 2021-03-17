source etc/config

current=$(pwd)
cd "$UserDir"
python "$LyXDir/configure.py"
cd "$current"
