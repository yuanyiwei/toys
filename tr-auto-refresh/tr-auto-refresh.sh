AUTH="Basic xxxxx=="
DEST="http://xxxxx/dl/rpc"

while true; do

# Transmission Session ID prevent CSRF
TSID=`curl -sI "$DEST" -H "Authorization: $AUTH" |grep -Fi "X-Transmission-Session-Id" | tr -d '\r'`
echo $TSID

# torrent-get ID, jq to Json
TDATA=`curl -s "$DEST" -H "Authorization: $AUTH" -H 'Accept-Encoding: gzip, deflate' -H "$TSID" -H 'Content-Type: json' -H 'Accept: application/json, text/javascript, */*; q=0.01' -H 'X-Requested-With: XMLHttpRequest' -H 'DNT: 1' --data-binary '{"method":"torrent-get","arguments":{"fields":["id"],"ids":"recently-active"}}' --compressed | jq -c '{"method":"torrent-reannounce","arguments":{ids: [.arguments.torrents[].id]}}' | tr -d '\r'`
echo $TDATA

# refresh peer
curl "$DEST" -H "Authorization: $AUTH" -H 'Accept-Encoding: gzip, deflate' -H "$TSID" -H 'Content-Type: json' -H 'Accept: application/json, text/javascript, */*; q=0.01' -H 'X-Requested-With: XMLHttpRequest' -H 'DNT: 1' --data-binary "$TDATA" --compressed

sleep 60
done
