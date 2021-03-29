source etc/util.sh
source etc/verify.sh

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

if [ -d "$TexMfHome" ]; then
  newfiles=$(diff -qr "$TexMfHome/tex/latex" LaTeX | grep "^Only in LaTeX/")
  cp -rv LaTeX/* $TexMfHome/tex/latex/

  if [ -z $newfiles ] || mktexlsr; then
    praise "You're all set!"
  else
    warn "mktexlsr failed."
    warn "You probably need 'sudo' for that. Try"
    warn
    warn "    sudo mktexlsr"
    warn
  fi
else
  warn "\$TexMfHome is not set. Please edit 'etc/config'"
fi
