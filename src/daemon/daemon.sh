# daemon.sh 
# script for helping in running the Clippy daemon

#!/bin/bash
DAEMON_NAME="clippy_daemon"
SYSTEM=$(uname)
LOG_FILE="/tmp/clippy/${DAEMON_NAME}.log"

#system check
system_check() {
	if [[ "$SYSTEM" == "Darwin" ]]; then 
		echo "System is running on macOS"
	elif [[ "$SYSTEM" == "Linux" ]]; then
		echo "System is running on Linux"
	else 
		echo "Cannot determine the current system."
		exit 1
	fi
}
#main loop
#startup function 

#stop function 

#status function

#daemon entry point

system_check
