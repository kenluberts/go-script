read -p 'Slot: ' SLOT
read -p 'Banner: ' BANNER
read -p 'User: ' USERID
read -s -p 'Password: ' PASSWD

getGlassieData()
{
  cat <<EOF
{
   "environment_variables": [
      {
         "name": "HOST",
         "secure": false,
         "value": "$SLOT"
      },
      {
         "name": "AEM_HOSTNAME",
         "secure": false,
         "value": "$SLOT.digital.hbc.com"
      },
      {
         "name": "BANNER",
         "secure": false,
         "value": "$BANNER"
      },
      {
         "name": "APPLICATION",
         "secure": false,
         "value": "publisher"
      },
      {
         "name": "SCALE",
         "secure": false,
         "value": "1"
      }
   ]
}
EOF
}

genNginxData()
{
  cat <<EOF
{
   "environment_variables": [
      {
         "name": "logstash_host",
         "secure": false,
         "value": "multi-elk-udp.digital.hbc.com"
      },
      {
         "name": "DOCKER_INSTANCE",
         "value": "$SLOT",
         "secure": false
      },
      {
         "name": "banner",
         "value": "$BANNER",
         "secure": false
       }
   ]
}
EOF
}

DATA=$(genNginxData)

for i in `cat nginx.txt`
do
  echo "Requesting deploy for $i"
  curl --url "http://go.digital.hbc.com/go/api/pipelines/$i/schedule" \
       -u "$USERID:$PASSWD" \
       -H 'Accept: application/vnd.go.cd.v1+json' \
       -H 'Content-Type: application/json' \
       -X POST \
       --data "$DATA"
  sleep 10
done

DATA=$(getGlassieData)
#Glassie
curl --url "http://go.digital.hbc.com/go/api/pipelines/frontend-glassie-slot-deploy-release/schedule" \
     -u "$USERID:$PASSWD" \
     -H 'Accept: application/vnd.go.cd.v1+json' \
     -H 'Content-Type: application/json' \
     -X POST \
     --data "$DATA"
