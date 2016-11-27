# set -x                                                # uncomment this line to enable debug mode

DELAY=10                                                # refresh time in seconds
LOGFILE=$(mktemp -t "axolla.XXXXXXXXXX")                # create a temp file to redirect axel logs to it
AXEL_PARAMS=$@                                          # save all passed parameter to give them to axel later

while :                                                 # 
do
    axel $AXEL_PARAMS > $LOGFILE &                      # run axel with saved patameters and redirect stdout into the temp file
    PID=$!                                              # save the pid of the axel instance process
    while :                                             #
    do
        > $LOGFILE                                      # clear the temp file
        sleep $DELAY                                    # wait a little for axel to write to the file again
        if [[ $(cat $LOGFILE | wc -c)  = 0 ]]; then     # check if the file is still empty
            break                                       # file was empty, break
        fi
    done
    if [[ $(ps | grep $PID | wc -l) = 0 ]]; then        # check if the axel process is still up
        break                                           # process is not running, we are done
    else
        kill $PID                                       # process was stucked, kill it, so we can run it again
    fi
done

rm -f $LOGFILE                                          # remove the temp file