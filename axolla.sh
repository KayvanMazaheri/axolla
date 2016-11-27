# set -x
DELAY=10
LOGFILE=$(mktemp -t "axolla.XXXXXXXXXX")
AXEL_PARAMS=$@
DIFF_PARAMS="-q"

while :
do
	axel $AXEL_PARAMS > $LOGFILE &
	PID=$!
	while :
	do
		> $LOGFILE
		sleep $DELAY
		if [[ $(cat $LOGFILE | wc -c)  = 0 ]]; then
			break
		fi
	done
	if [[ $(ps | grep $PID | wc -l) = 0 ]]; then
		break
	else
		kill $PID
	fi
done