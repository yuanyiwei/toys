#/bin/bash

URL="http://www.baidu.com"
NAME="totototoro"
PASS="totototoro"

check() {
    RESULT=$(curl -s $URL | grep "<title>redirecting to http://wlt.ustc.edu.cn</title>")
    echo $RESULT
    
    if [ "$RESULT" = "<title>redirecting to http://wlt.ustc.edu.cn</title>" ] ; then
        echo "Down"
        curl -vso /dev/null "http://wlt.ustc.edu.cn/cgi-bin/ip?cmd=set&url=URL&type=0&exp=0&name=$NAME&password=$PASS"
        sleep 5

        RESULT2=$(curl -s $URL | grep "<title>redirecting to http://wlt.ustc.edu.cn</title>")
        echo $RESULT2

        if [ "$RESULT2" = "<title>redirecting to http://wlt.ustc.edu.cn</title>" ] ; then
            echo "Error"
            exit -1
        elif [ -z "$RESULT" ] ; then
            echo "Get WLT"
            exit 0
        fi

    elif [ -z "$RESULT" ] ; then
        echo "OK"
        exit 0
    else 
        echo "Error"
    fi
}

check