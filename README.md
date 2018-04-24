# go-script

This is a simple script to execute some of the go pipelines for a slot refresh for GOCD.  This is currently only set up to run the slot deploy pipelines for our scala services.  Review the list.txt file for the pipelines that will be scheduled with this script.

You should be prompted to enter a go server unless you set the GO_SERVER variable in your shell.

export GO_SERVER="[enter hostname]" <- preferably the FQDN of the GO master server.

./go.sh