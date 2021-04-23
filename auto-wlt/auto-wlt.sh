#/bin/bash

URL="http://www.baidu.com"
NAME="totototoro"
PASS="totototoro"

check() {
    RESULT=$(curl -s $URL | grep "<title>redirecting to http://wlt.ustc.edu.cn</title>")
    echo $RESULT
    
    if [ "$RESULT" -eq "<title>redirecting to http://wlt.ustc.edu.cn</title>" ] ; then # bug for eq
        echo "Down"
        curl -vso /dev/null "http://wlt.ustc.edu.cn/cgi-bin/ip?cmd=set&url=URL&type=0&exp=0&name=$NAME&password=$PASS"
        sleep 10
        check
    elif [ "$RESULT" -eq "" ] ; then
        echo "OK"
        exit 0
    else 
        echo "Error"
    fi
}

check