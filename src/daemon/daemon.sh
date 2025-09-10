# daemon.sh 
# script for helping in running the Clippy daemon

#!/bin/bash
DAEMON_NAME="clippy_daemon"
SYSTEM=$(uname)
LOG_FILE="/tmp/clippy/${DAEMON_NAME}.log"
PID_FILE="/tmp/clippy/${DAEMON_NAME}.pid"
OUT_FILE="/tmp/clippy/outputs/${DAEMON_NAME}.txt"


#unix main loop
unix_loop() {
	local buf
	local clipboard=$(pbpaste) #pbpaste pastes the content of the clipboard
	if [[ ! -f $OUT_FILE ]]; then # create output file if it doesnt exist yet
		touch $OUT_FILE
	fi
	while true #main loop
	do
		if [[ $buf != $clipboard ]]; then # buffer write occurs only when different from the current
			buf=$clipboard
			echo "$buf" >> $OUT_FILE
		fi
	done
	sleep 0.4
}
#linux main loop

#startup function 
startup_daemon() {
	if [[ -f $PID_FILE ]]; then
		echo "Process $(cat $PID_FILE) is already running"
		exit 1
	else 
		echo "$$" >> $PID_FILE
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
	else 
		local pid=$(cat $PID_FILE)
		if kill $pid; then
			rm $PID_FILE
			echo "Process $pid stopped successfully"
		else 
			echo "Cannot kill process"
		fi
	fi
}
#status function
status_daemon() {
	pid=$(cat $PID_FILE)
	if kill -0 "$pid" >/dev/null 2>&1; then
		echo "Process $pid is running"
	else
		echo "Process is not running"
	fi
}

#daemon entry point

case $1 in
	start)
		startup_daemon	
		;;
	stop)
		stop_daemon
		;;
	status) 
		status_daemon
		;;
	*) 
		echo "Usage: clippy (start | stop | status)"
		exit 1;
esac

