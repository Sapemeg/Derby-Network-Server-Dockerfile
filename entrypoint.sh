#!/usr/bin/env bash

trap stop INT TERM
LOGDIR=/var/log/db-derby
LOGFILE=d-db-derby.log
PIDFILE=pid.txt

start(){
   
    cd $LOGDIR
    local pid

	# hacky way to "initialize" the output file
	echo " " >> $LOGFILE

	tail --pid $$ -n 0 -F "${LOGFILE}" &

    echo "$(date +'%F %T,%3N') Starting Networked Apache Derby " >> "$LOGFILE"

    java -jar /opt/Apache/db-derby-10.14.2.0-bin/lib/derbyrun.jar server start >> ${LOGFILE} 2>&1 &

	pid=$!

    echo "$pid" > $PIDFILE
	
	wait "$pid"
   
   }

stop(){

   echo "$(date +'%F %T,%3N') Stopping Networked Apache Derby" >> "$LOGFILE"
   
   java -jar /opt/Apache/db-derby-10.14.2.0-bin/lib/derbyrun.jar server shutdown >> ${LOGFILE}  &

   wait $(cat "${PIDFILE}")

   sleep 2

   exit
}

start
