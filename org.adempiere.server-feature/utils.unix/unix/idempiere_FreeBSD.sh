#!/bin/sh
# iDempiere ERP FreeBSD rc.d init script
# Harte & Lyne Limited 2020-09-03 JBB

# PROVIDE: idempiere
# REQUIRE: postgresql
# KEYWORD: shutdown

# Bring in init subroutines (. instead of source is too cryptic for me)
. /etc/rc.subr

# Identify and load rc.conf variabless for this process
name="idempiere" 
load_rc_config $name

# run at boot switch
rcvar=idempiere_enable

idempiere_enable=${idempiere_enable:-"NO"}
idempiere_home=${idempiere_home:-"`find / -path \*idempiere-server -type d | sort | head -1`"}
#idempiere_java=${idempiere_java:-"/usr/local/openjdk12"}
idempiere_javahome=${idempiere_javahome:-"`find / -path \*jdk\* -type d | sort | head -1`"}
idempiere_logfile=${idempiere_logfile:-"/var/log/idempiere_`date +%Y%m%d%H%M%S`.log"}
#idempiere_logfile=${idempiere_logfile:-"/tmp/log/idempiere_`date +%Y%m%d%H%M%S`.log"}
idempiere_pidfile=${idempiere_pidfile:-"/var/run/idempiere/idempiere.pid"}
idempiere_telnet_port=${idempiere_telnet_port:-"12612"}
idempiere_user=${idempiere_user:-"idempiere"}
idempiere_group=${idempiere_group:-"idempiere"}

export IDEM_HOME="$idempiere_home"
export IDEM_LOG="$idempiere_logfile"
export IDEM_LOG_DIR=`dirname $IDEM_LOG`
export IDEM_PID="$idempiere_pidfile"
export IDEM_PID_DIR=`dirname $IDEM_PID`
export IDEM_SCRIPT="$IDEM_HOME/idempiere-server.sh"
export IDEM_TELNET="$idempiere_telnet_port"
export IDEM_USER="$idempiere_user"

export JAVA_HOME=$idempiere_javahome
export SU=su

start_cmd="${name}_start"
status_cmd="${name}_status"
stop_cmd="${name}_stop"

extra_commands="status"

idempiere_describe()
{
  echo "This script controls the start and stop of the idempiere process."
}

idempiere_pid()
{
  export IDEM_PID=`ps -acux | grep java | grep $IDEM_USER | cut -w -f 2 -`
  export IDEM_LOG_PREFIX="$(date +%c) $(hostname -s) $name[$IDEM_PID]:"
}

idempiere_restart()
{
  idempiere_stop
  idempiere_start
}

idempiere_start()
{ 
  idempiere_pid
  if [ -n "$IDEM_PID" ]
  then
    echo "$name is already running with pid $IDEM_PID"
    return
  else
    echo "Starting idempiere"
    echo "idempiere logfile=$idempiere_logfile"
    mkdir -p $IDEM_LOG_DIR
    touch ${idempiere_logfile}
    chmod 660 ${idempiere_logfile}
    chown "$idempiere_user:$idempiere_group" ${idempiere_logfile}
    ln -sf ${idempiere_logfile} "$IDEM_LOG_DIR"/idempiere.log
    $SU ${IDEM_USER} -c "export TELNET_PORT=$IDEM_TELNET;cd $IDEM_HOME;$IDEM_SCRIPT > $IDEM_LOG 2>&1 &"
    sleep 5
  fi
  idempiere_pid
  if [ -n "$IDEM_PID" ]
  then
    mkdir -p $IDEM_PID_DIR
    echo "$IDEM_PID" > ${idempiere_pidfile}
    chmod 660 "$idempiere_pidfile" 
    chown "$idempiere_user:$idempiere_group" ${idempiere_pidfile}
    echo "$name started with pid $IDEM_PID"
    echo "$IDEM_LOG_PREFIX started with pid $IDEM_PID" >> "$IDEM_LOG_DIR"/idempiere_init.log
  else
    echo "$name did not start"
    return 1
  fi
}

idempiere_status()
{
  idempiere_pid
  if [ -n "$IDEM_PID" ]
  then
    echo "$name is running as PID $IDEM_PID"
  else
    echo "$name is not running"
  fi
}

idempiere_stop()
{
  idempiere_pid
  if [ -z "$IDEM_PID" ]
  then
    echo "$name is not running"
    return
  else
    echo "stopping $name via OSGI console"
    echo "$(date +%c) $(hostname -s) $name[$IDEM_PID]: stopping $name via OSGI console"  >> "$IDEM_LOG_DIR"/idempiere_init.log
    ( echo exit; echo y; sleep 5 ) | telnet localhost $IDEM_TELNET
  fi
  idempiere_pid
  if [ -z "$IDEM_PID" ]
  then
    echo "$name stopped using OSGI console" 
    echo "$IDEM_LOG_PREFIX stopped using OSGI console" >> "$IDEM_LOG_DIR"/idempiere_init.log
    rm -f ${idempiere_pidfile}
    return
  else
    echo "$name failed to stop using OSGI console" 
    echo "$IDEM_LOG_PREFIX failed to stop using OSGI console" >> "$IDEM_LOG_DIR"/idempiere_init.log
    echo "stopping $name via SIGTERM"
    echo "$IDEM_LOG_PREFIX stopping via SIGTERM" >> "$IDEM_LOG_DIR"/idempiere_init.log
    kill -SIGTERM "$IDEM_PID"
    sleep 5
  fi
  idempiere_pid
  if [ -z "$IDEM_PID" ]
  then
    echo "$name stopped using SIGTERM"
    echo "$IDEM_LOG_PREFIX stopped using SIGTERM" >> "$IDEM_LOG_DIR"/idempiere_init.log
    rm -f ${idempiere_pidfile}
    return
  else
    echo "$name failed to stop using SIGTERM"
    echo "$IDEM_LOG_PREFIX failed to stop using SIGTERM" >> "$IDEM_LOG_DIR"/idempiere_init.log
    echo "stopping $name via SIGKILL"
    echo "$IDEM_LOG_PREFIX stopping via SIGKILL" >> "$IDEM_LOG_DIR"/idempiere_init.log
    kill -SIGKILL "$IDEM_PID"
    sleep 5
  fi
  idempiere_pid
  if [ -z "$IDEM_PID" ]
  then
    echo "$name stopped using SIGKILL"
    echo "$IDEM_LOG_PREFIX stopped using SIGKILL" >> "$IDEM_LOG_DIR"/idempiere_init.log
    rm -f ${idempiere_pidfile}
    return
  else
    echo "$name failed to stop using SIGKILL"
    echo "$IDEM_LOG_PREFIX failed to stop using SIGKILL" >> "$IDEM_LOG_DIR"/idempiere_init.log
    echo "unable to stop $name with pid $IDEM_PID"
    return 1
  fi
}

run_rc_command "$1"
