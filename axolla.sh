# set -x
DELAY=10
LOGFILE=log.txt
AXEL_PARAMS=$@
DIFF_PARAMS="-q"

for (( ; ; ))
do
	axel $AXEL_PARAMS >> $LOGFILE &
	PID=$!
	for (( ; ; ))
	do
		cp -T -f $LOGFILE $LOGFILE.OLD
		sleep $DELAY
		if [[ $(diff $DIFF_PARAMS $LOGFILE $LOGFILE.OLD | wc -l)  = 0 ]]; then
			break
		fi
	done
	if [[ $(ps | grep $PID | wc -l) = 0 ]]; then
		break
	else
		kill $PID
	fi
done