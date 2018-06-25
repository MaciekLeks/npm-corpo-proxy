
encode() {
  s="${1//'%'/%25}"
  s="${s//'\'/%5C}"
  s="${s//' '/%20}"
  s="${s//'"'/%22}"
  s="${s//'#'/%23}"
  s="${s//'$'/%24}"
  s="${s//'&'/%26}"
  s="${s//'+'/%2B}"
  s="${s//','/%2C}"
  s="${s//'/'/%2F}"
  s="${s//':'/%3A}"
  s="${s//';'/%3B}"
  s="${s//'='/%3D}"
  s="${s//'?'/%3F}"
  s="${s//'@'/%40}"
  s="${s//'['/%5B}"
  s="${s//']'/%5D}"
  printf %s "$s"
}

usage="\nUsage: npm-domain-proxy on|off [domain] [user] [passwd] [host:port]\n"

if [ "$1" == "on" ]; then
    if [ "$#" -ne 5 ]; then
        printf "err: Wrong number of arguments.$usage"
        exit $?
    fi

    username=$2'\'$3
    passwd=$4
    listener=$5
    #printf "Setting 'proxy' and 'https-proxy' using $username:$passwd@$listener...\n"

    username=$(encode $username)
    passwd=$(encode $passwd)

    url="http://$username:$passwd@$listener"

    npm config set proxy $url &> /dev/null;
    if [ $? -ne 0 ]; then
        printf "'proxy' not set\n"
        exit 1
    else
        printf "'proxy' set\n"
    fi

    npm config set https-proxy $url &> /dev/null;
    if [ $? -ne 0 ]; then
        printf "'https-proxy' not set\n"
        exit 1
    else
        printf "'https-proxy' set\n"
    fi
    echo $url
elif [ "$1" == "off" ]; then
    if [ "$#" -ne 1 ]; then
        printf  "err: Wrong number of arguments.$usage"
        exit $?
    fi

    npm config rm proxy &> /dev/null
    if [ $? -ne 0 ]; then
        printf "'proxy' still set\n"
        exit 1
    else
        printf "'proxy' unset\n"
    fi
    npm config rm https-proxy &> /dev/null
    if [ $? -ne 0 ]; then
        printf "'https-proxy' still set\n"
        exit 1
    else
        printf "'https-proxy' unset\n"
    fi
else
    printf  "err: Unknown first argument.$usage"
    exit 1
fi

exit $?
