#!/bin/sh
#

### BEGIN INIT INFO
# Provides:			idempiere
# Required-Start:	postgresql
# Required-Stop:	postgresql
# Default-Start:	2 3 4 5
# Default-Stop:		1
# Short-Description:	iDempiere 1.0.0 server
# Description:			Provides iDempiere ERP-CRM Server startup and shutdown script. Requires PostgreSQL server.
# FileTarget:	/etc/init.d/idempiere
# FileOwner:	root.root
# FilePerms:	0755
#
# chkconfig:	2345 97 06
### END INIT INFO

# initialization
# adjust these variables to your environment
IDEMPIERE_HOME=/home/idempiere/idempiere-server
IDEMPIEREUSER=idempiere
# Instead of using ENVFILE you can set JAVA_HOME, IDEMPIERE_HOME and add JAVA_HOME/bin to PATH
# in this case you can comment the source lines for ENVFILE below
# detected some problems with Hardy Heron ubuntu using the bash source command
ENVFILE=$IDEMPIERE_HOME/utils/myEnvironment.sh

. /lib/lsb/init-functions
 
RETVAL=0
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
        return 1
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
            log_warning_msg "Service hasn't started within the timeout allowed, please review file $LOGFILE to see the status of the service"
        else
            log_success_msg "Service started"
        fi
        echo
    else
        log_failure_msg "Service not started"
    echo
    fi
    RETVAL=$?
    return $RETVAL
}

stop () {
    getidempierestatus
    if [ $IDEMPIERESTATUS -ne 0 ] ; then
	  echo "iDempiere is already stopped"
	  return 1
    fi
    echo -n "Stopping iDempiere ERP: "
    cd $IDEMPIERE_HOME/utils
    . $ENVFILE 
    log_warning_msg "Trying direct kill with signal -15"
    # try direct kill with signal 15, then signal 9
    kill -15 -`ps ax o pgid,command | grep -v grep | grep $IDEMPIERE_HOME | sed -e 's/^ *//g' | cut -f 1 -d " "`
    sleep 5
    getidempierestatus
    if [ $IDEMPIERESTATUS -ne 0 ] ; then
	  log_success_msg "Service stopped with kill -15"
    else
	  echo "Trying direct kill with signal -9"
	  kill -9 -`ps ax o pgid,command | grep -v grep | grep $IDEMPIERE_HOME | sed -e 's/^ *//g' | cut -f 1 -d " "`
	  sleep 5
	  getidempierestatus
	  if [ $IDEMPIERESTATUS -ne 0 ] ; then
	    log_success_msg "Service stopped with kill -9"
	  else
	    log_warning_msg "Service hasn't stopped"
	  fi
    fi
    return $RETVAL
}

restart () {
    stop
    sleep 1
    start
}

condrestart () {
    getidempierestatus
    if [ $IDEMPIERESTATUS -eq 0 ] ; then
	   restart
    fi
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
    fi
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

exit 0
