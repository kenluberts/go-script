read -p 'Slot: ' SLOT
read -p 'User: ' USERID
read -s -p 'Password: ' PASSWD

for i in `cat list.txt`
do
  echo "Requesting deploy for $i"
  curl http://hd1cmgo01lx.digital.hbc.com:8153/go/api/pipelines/$i/schedule \
    -u "$USERID:$PASSWD" \
    -H "Confirm: true" \
    -X POST --data "variables[DOCKER_INSTANCE]=$SLOT"
  sleep 10
done
