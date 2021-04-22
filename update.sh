#!/bin/bash

#https://www.ve2dbe.com/download/download.html

TMPDIR=$(mktemp -d)
RMWDIR="${HOME}/.wine/drive_c/Radio_Mobile"

rmwoldsha256=$(sha256sum "$RMWDIR"/rmwspa.exe | cut -d ' ' -f1)
rmwnewsha256=

cd "$TMPDIR"
wget https://www.ve2dbe.com/download/rmw1166spa.zip
unzip rmw1166spa.zip
rmwnewsha256=$(sha256sum rmwspa.exe | cut -d ' ' -f1)
if [ "$rmwoldsha256" = "$rmwnewsha256" ]; then
	logger "Radio Mobile is already the last version"
else
	ctrl=$(zenity --question --text="Update Radio Mobile?")
	read ctrl
	case $ctrl in
		[yY][eE][sS])
				mv * "$RMWDIR"
				logger "Radio Mobile updated"
				;;
		[nN][oO])
			;;
	esac
	
fi	
