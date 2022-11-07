#!/usr/bin/env bash
# Alert.sh_Update_2022-10-31

SYSLOGSERVER="x.x.x.x" 
SRV_HOSTNAME=$(hostname -f)
SRV_IP=$(hostname -I | awk '{print $1}')
PROXY="http://x.x.x.x"

if [ "$PAM_TYPE" == "open_session" ]; then
    COUNTRY=$(curl --proxy $PROXY -s ipinfo.io/${PAM_RHOST} | awk -F ':' '/country/ {print $2}' | sed 's/"//gi' | sed 's/,//gi')
    TEXT="$SRV_IP($SRV_HOSTNAME) Connect ssh session / User=${PAM_USER} / Client IP : ${PAM_RHOST}($COUNTRY)"
    logger -n $SYSLOGSERVER ${TEXT}
elif [ "$PAM_TYPE" == "close_session" ]; then
    COUNTRY=$(curl --proxy $PROXY -s ipinfo.io/${PAM_RHOST} | awk -F ':' '/country/ {print $2}' | sed 's/"//gi' | sed 's/,//gi')
    TEXT="$SRV_IP($SRV_HOSTNAME) Terminate ssh session / User=${PAM_USER} / Client IP ${PAM_RHOST}($COUNTRY)"
    logger -n $SYSLOGSERVER ${TEXT}
else
    COUNTRY=$(curl --proxy $PROXY -s ipinfo.io/${PAM_RHOST} | awk -F ':' '/country/ {print $2}' | sed 's/"//gi' | sed 's/,//gi')
    TEXT="$SRV_IP($SRV_HOSTNAME) Terminate ssh session / User=${PAM_USER} / Client IP ${PAM_RHOST}($COUNTRY)"
    logger -n $SYSLOGSERVER ${TEXT}
fi
exit
