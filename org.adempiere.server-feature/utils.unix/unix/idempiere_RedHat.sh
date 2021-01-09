#!/bin/bash
#
# FileName:	idempiere.init
# Description:	idempiere erp software startup and shutdown
# Vendor:	K.K. Alice
# Created:	05. April 2004
# Author:	S. Christians
# Updated:	Carlos Ruiz - globalqss - tested in Redhat FC4
#               Carlos Ruiz - globalqss - added timeout review of the log file
#
# FileTarget:	/etc/init.d/idempiere
# FileOwner:	root.root
# FilePerms:	0755
#
# chkconfig:	2345 97 06
# $Id: idempiere,v 1.1 2006/03/16 05:00:28 cruiz Exp $

# initialization
# adjust these variables to your environment
IDEMPIERE_HOME=/opt/idempiere-server
ENVFILE=$IDEMPIERE_HOME/utils/myEnvironment.sh
IDEMPIEREUSER=idempiere
export TELNET_PORT=12612

. /etc/rc.d/init.d/functions

RETVAL=0
IDEMPIERESTATUS=
MAXITERATIONS=60 # 2 seconds every iteration, max wait 2 minutes

getidempierestatus() {
    IDEMPIERESTATUSSTRING=$(ps ax | grep java | grep ${IDEMPIERE_HOME} | grep -v grep)
    echo "$IDEMPIERESTATUSSTRING" | grep -q ${IDEMPIERE_HOME}
    IDEMPIERESTATUS=$?
}

start () {
    getidempierestatus
    if [ $IDEMPIERESTATUS -eq 0 ] ; then
	  echo "iDempiere is already running"
	  return 1
    fi
    echo -n "Starting iDempiere ERP: "
    cd $IDEMPIERE_HOME/utils || exit
    export ID_ENV=Server
    source $ENVFILE
    export LOGFILE=$IDEMPIERE_HOME/log/idempiere_$(date +%Y%m%d%H%M%S).log
    su $IDEMPIEREUSER -c "mkdir -p $IDEMPIERE_HOME/log"
    su $IDEMPIEREUSER -c "export TELNET_PORT=$TELNET_PORT;cd $IDEMPIERE_HOME;$IDEMPIERE_HOME/idempiere-server.sh &> $LOGFILE &"
    RETVAL=$?
    if [ $RETVAL -eq 0 ] ; then
	# wait for server to be confirmed as started in logfile
	STATUSTEST=0
	ITERATIONS=0
	while [ $STATUSTEST -eq 0 ] ; do
	    sleep 2
	    grep -q '.*LoggedSessionListener.contextInitialized: context initialized.*' < "$LOGFILE" && STATUSTEST=1
	    echo -n "."
	    ITERATIONS=$((ITERATIONS + 1))
	    if [ $ITERATIONS -gt $MAXITERATIONS ]
		then
		   break
	    fi
	done
	if [ $STATUSTEST -eq 0 ]
	then
	    echo "Service hasn't started within the timeout allowed, please review file $LOGFILE to see the status of the service"
	    echo_warning
	else
	    echo_success
	fi
	echo
    else
	echo_failure
	echo
    fi
    return $RETVAL
}

stop () {
    getidempierestatus
    if [ $IDEMPIERESTATUS -ne 0 ] ; then
	  echo "iDempiere is already stopped"
	  return 1
    fi
    echo -n "Stopping iDempiere ERP: "
    cd $IDEMPIERE_HOME/utils || exit
    export ID_ENV=Server
    source $ENVFILE
    # try shutdown from OSGi console, then direct kill with signal 15, then signal 9
    echo "Trying shutdown from OSGi console"
    ( echo exit; echo y; sleep 5 ) | telnet localhost ${TELNET_PORT} > /dev/null 2>&1
    getidempierestatus
    if [ $IDEMPIERESTATUS -ne 0 ] ; then
        echo_success
    else
        echo "Trying direct kill with signal -15"
        kill -15 -$(ps ax o pgid,command | grep ${IDEMPIERE_HOME} | grep -v grep | sed -e 's/^ *//g' | cut -f 1 -d " " | sort -u)
        sleep 5
        getidempierestatus
        if [ $IDEMPIERESTATUS -ne 0 ] ; then
            echo_success
        else
            echo "Trying direct kill with signal -9"
            kill -9 -$(ps ax o pgid,command | grep ${IDEMPIERE_HOME} | grep -v grep | sed -e 's/^ *//g' | cut -f 1 -d " " | sort -u)
            sleep 5
            getidempierestatus
            if [ $IDEMPIERESTATUS -ne 0 ] ; then
                echo_success
            else
                echo_warning
            fi
        fi
    fi
	RETVAL=$?
    return $RETVAL
}

restart () {
    stop
    sleep 2
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
	ps ax | grep ${IDEMPIERE_HOME} | grep -v grep | sed 's/^[[:space:]]*\([[:digit:]]*\).*:[[:digit:]][[:digit:]][[:space:]]\(.*\)/\1 \2/'
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
	echo $"Usage: $0 {start|stop|restart|condrestart|status}"
	exit 1
esac

exit 0
