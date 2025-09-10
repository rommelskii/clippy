# daemon.sh 
# script for helping in running the Clippy daemon

#!/bin/bash
DAEMON_NAME="clippy_daemon"
SYSTEM=$(uname)
LOG_FILE="/tmp/clippy/${DAEMON_NAME}.log"
PID_FILE="/tmp/clippy/${DAEMON_NAME}.pid"


#unix main loop
#linux main loop

#startup function 
startup_daemon() {
	if [[ -f $PID_FILE ]]; then
		echo "Process ${cat $(PID_FILE)} is already running"
		exit 1
	fi
	case $SYSTEM in 
		"Darwin")
			unix_loop
			;;
		"Linux")
			linux_loop
			;;
		*)
			echo "System cannot be determined"
			exit 1
			;;
	esac
}

#stop function 
stop_daemon() {
	if [[ ! -f $PID_FILE ]]; then
		echo "Daemon is not running!"		
		exit 1
	fi
	kill $(cat $PID_FILE)
	echo "Process $(cat $PID_FILE) stopped successfully"
}
#status function

#daemon entry point

case $1 in
	start)
		start_daemon
		;;
	stop)
		stop_daemon
		;;
	status) 
		status_daemon
		;;
esac

