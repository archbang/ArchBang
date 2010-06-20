#!/bin/bash
#xcompmgr -CcfF -I-.015 -O-.03 -D6 -t-1 -l-3 -r4.2 -o.5 &
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
    eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi 
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
exec ck-launch-session startlxde

