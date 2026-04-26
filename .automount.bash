#!/bin/bash
pidfile=/tmp/automount.pid

if [[ -e $pidfile ]] && kill -0 "$(cat $pidfile)" 2>/dev/null; then
    echo "already running" && exit 1
fi

# permit persist keepenv :wheel as root
# permit nopass :wheel as root cmd mount
# permit nopass :wheel as root cmd umount

echo $$ > $pidfile
trap "rm -f $pidfile" EXIT

udevadm monitor --udev --subsystem-match=block | while read -r _ _ action dev _; do
    node=/dev/$(basename "$dev")
	case "$action" in
		"add")
			doas mount -o rw,umask=000 "$node" ~/mnt2 && notify-send "mounted $node"
			;;
		"remove")
			notify-send "unmounted $node"
			;;
	esac
done

