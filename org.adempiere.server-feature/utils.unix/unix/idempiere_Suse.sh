#!/bin/sh
# Copyright (c) 2014 Carlos Ruiz - GlobalQSS
# All rights reserved.
#
# System startup script for iDempiere
#
# LSB compatible service control script; see http://www.linuxbase.org/spec/
#
### BEGIN INIT INFO
# Provides:       idempiere
# Required-Start:
# Required-Stop:
# Default-Start:  3 5
# Default-Stop:   
# Description:    Start the iDempiere server
### END INIT INFO

# initialization
# adjust these variables to your environment
IDEMPIERE_HOME=/opt/idempiere-server
IDEMPIEREUSER=idempiere
# Instead of using ENVFILE you can set JAVA_HOME, IDEMPIERE_HOME and add JAVA_HOME/bin to PATH
# in this case you can comment the source lines for ENVFILE below
# detected some problems with Hardy Heron ubuntu using the bash source command
ENVFILE=$IDEMPIERE_HOME/utils/myEnvironment.sh

# Shell functions sourced from /etc/rc.status:
#      rc_check         check and set local and overall rc status
#      rc_status        check and set local and overall rc status
#      rc_status -v     ditto but be verbose in local rc status
#      rc_status -v -r  ditto and clear the local rc status
#      rc_failed        set local and overall rc status to failed
#      rc_reset         clear local rc status (overall remains)
#      rc_exit          exit appropriate to overall rc status
. /etc/rc.status

# The echo return value for success (defined in /etc/rc.config).
rc_reset

# Return values acc. to LSB for all commands but status:
# 0 - success
# 1 - generic or unspecified error
# 2 - invalid or excess argument(s)
# 3 - unimplemented feature (e.g. "reload")
# 4 - insufficient privilege
# 5 - program is not installed
# 6 - program is not configured
# 7 - program is not running
# 
# Note that starting an already running service, stopping
# or restarting a not-running service as well as the restart
# with force-reload (in case signalling is not supported) are
# considered a success.

# 
IDEMPIERESTATUS=
MAXITERATIONS=60 

getidempierestatus() {
    IDEMPIERESTATUSSTRING=$(ps ax | grep -v grep | grep $IDEMPIERE_HOME)
    echo $IDEMPIERESTATUSSTRING | grep -q $IDEMPIERE_HOME
    IDEMPIERESTATUS=$?
}

start () {
    getidempierestatus
    if [ $IDEMPIERESTATUS -eq 0 ] ; then
        echo "iDempiere is already running"
        rc_failed 0
	return
    fi
    echo -n "Starting iDempiere ERP: "
    cd $IDEMPIERE_HOME/utils
    . $ENVFILE 
    export LOGFILE=$IDEMPIERE_HOME/log/idempiere_`date +%Y%m%d%H%M%S`.log
    su $IDEMPIEREUSER -c "mkdir -p IDEMPIERE_HOME/log"
    su $IDEMPIEREUSER -c "cd $IDEMPIERE_HOME;$IDEMPIERE_HOME/idempiere-server.sh &> $LOGFILE &"
    RETVAL=$?
    if [ $RETVAL -eq 0 ] ; then
        # wait for server to be confirmed as started in logfile
        STATUSTEST=0
        ITERATIONS=0
        while [ $STATUSTEST -eq 0 ] ; do
            sleep 2
            tail -n 9 $LOGFILE | grep -q '.*WebUIServlet.*started successfully.*' && STATUSTEST=1
            echo -n "."
            ITERATIONS=`expr $ITERATIONS + 1`
            if [ $ITERATIONS -gt $MAXITERATIONS ]
                then
                break
            fi
        done
        if [ $STATUSTEST -eq 0 ]
        then
            echo "Service hasn't started within the timeout allowed, please review file $LOGFILE to see the status of the service"
	    rc_failed 1
        else
            echo "Service started"
        fi
        echo
    else
        echo "Service not started"
	rc_failed 1
    fi
    rc_status -v
}

stop () {
    getidempierestatus
    if [ $IDEMPIERESTATUS -ne 0 ] ; then
	echo "iDempiere is already stopped"
	rc_failed 0
	return
    fi
    echo -n "Stopping iDempiere ERP: "
    cd $IDEMPIERE_HOME/utils
    . $ENVFILE 
    echo "Trying direct kill with signal -15"
    # try direct kill with signal 15, then signal 9
    kill -15 -`ps ax o pgid,command | grep -v grep | grep $IDEMPIERE_HOME | sed -e 's/^ *//g' | cut -f 1 -d " " | sort -u`
    sleep 5
    getidempierestatus
    if [ $IDEMPIERESTATUS -ne 0 ] ; then
	  echo "Service stopped with kill -15"
    else
	  echo "Trying direct kill with signal -9"
	  kill -9 -`ps ax o pgid,command | grep -v grep | grep $IDEMPIERE_HOME | sed -e 's/^ *//g' | cut -f 1 -d " " | sort -u`
	  sleep 5
	  getidempierestatus
	  if [ $IDEMPIERESTATUS -ne 0 ] ; then
	    echo "Service stopped with kill -9"
	  else
	    echo "Service hasn't stopped"
	    rc_failed 1
	  fi
    fi
    rc_status -v
}

restart () {
    stop
    sleep 1
    start
    rc_status
}

condrestart () {
    getidempierestatus
    if [ $IDEMPIERESTATUS -eq 0 ] ; then
	restart
    else
	rc_reset        # Not running is not a failure.
    fi
    rc_status
}

status () {
    getidempierestatus
    if [ $IDEMPIERESTATUS -eq 0 ] ; then
	echo
	echo "iDempiere is running:"
	ps ax | grep -v grep | grep $IDEMPIERE_HOME | sed 's/^[[:space:]]*\([[:digit:]]*\).*:[[:digit:]][[:digit:]][[:space:]]\(.*\)/\1 \2/'
	echo
    else
	echo "iDempiere is stopped"
	rc_failed 3
    fi
    rc_status -v
}

case "$1" in
    start)
	start
	;;
    stop)
	stop
	;;
    reload)
	restart
	;;
    restart)
	restart
	;;
    condrestart)
	condrestart
	;;
    status)
	status
	;;
    *)
	echo $"Usage: $0 {start|stop|reload|restart|condrestart|status}"
	exit 1
esac

# Inform the caller not only verbosely and set an exit status.
rc_exit
