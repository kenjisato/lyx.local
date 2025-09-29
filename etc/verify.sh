verify_cfg() {
  if [ ! -e "$1" ]; then
    echo "$1" does not exist.
    return 1
  else
    source "$1"
  fi
  python_required=('2.7.*' '3.5.*' '3.6.*' '3.7.*' '3.8.*' '3.9.*', '3.1*')
  lyxdir_needs=configure.py
  userdir_needs=configure.log

  success=true
  if [ ! -e "$Python" ]; then
    warn "✗ Python: FATAL! I cannot find Python."
    success=false
  else
    python_version=$("$Python" -c "import platform; print(platform.python_version())")
    if is_in "$python_version" "${python_required[@]}"; then
      praise "✔ Python: version is $python_version."
    else
      warn "✗ Python: WARNING! Python 2 \> 2.7 or 3 \> 3.5 is expected. You have $python_version."
      success=false
    fi
  fi

  if [ -e "$LyXDir/$lyxdir_needs" ]; then
    praise "✔ LyXDir: contains '$lyxdir_needs'".
  else
    warn "✗ LyXDir: FATAL! Your \<LyXDir\> does not contain '$lyxdir_needs'."
    succes=false
  fi

  if [ -e "$UserDir"/"$userdir_needs" ]; then
    praise "✔ UserDir: contains '$userdir_needs'."
  else
    warn "✗ UserDir: WARNING! Your \<UserDir\> does not contain '$userdir_needs'."
    echo "    I am not sure whether your configurations are intentional."
    echo "    Running '$userdir_needs' in the <UserDir> you specify could end up with"
    echo "    a VERY unpleasant situation. So, I do not proceed. If you think this"
    echo "    is the right place, please run LyX in there before using my scripts."
    success=false
  fi

  if [ -d "$TexMfHome" ]; then
    praise "✔ TexMfHome: TEXMFHOME directory is set."
  else
    echo "TexMfHome: TEXMFHOME directory is not set. Ignored."
  fi

  if "${success}"; then
    return 0
  else
    warn "Sorry, config verication failed. Please manually edit 'etc/config'."
    echo "   Python .... path to Python 2.7+ or 3.5+"
    echo "   LyX    .... path to LyX application"
    echo "   LyXDir .... path to LyX's system directory (typically, 'Resources' directory)"
    echo "   UserDir.... path to LyX's user directory"
    return 1
  fi
}
