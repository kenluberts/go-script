read -p 'Go Server: ' GO_SERVER
read -p 'Slot: ' SLOT
read -p 'User: ' USERID
read -s -p 'Password: ' PASSWD

if [[ ! -z $GO_SERVER ]];
then
  for i in `cat list.txt`
  do
    echo "Requesting deploy for $i"
    curl http://$GO_SERVER:8153/go/api/pipelines/$i/schedule \
      -u "$USERID:$PASSWD" \
      -H "Confirm: true" \
      -X POST --data "variables[DOCKER_INSTANCE]=$SLOT"
    sleep 10
  done
else
  echo "Go Server cannot be blank"
fi

