ping -c 1 proxypac.si.francetelecom.fr >/dev/null 2<&1
if [ $? = 0 ]; then
  echo "Orange proxy enabled"
  export http_proxy="http://localhost:3128"
  export https_proxy="http://localhost:3128"
  docker restart cntlm
  #export http_proxy="http://proxypac.si.francetelecom.fr:8080"
  #export https_proxy="http://proxypac.si.francetelecom.fr:8080"
else
  echo "Orange proxy disabled"
  unset http_proxy https_proxy
fi
