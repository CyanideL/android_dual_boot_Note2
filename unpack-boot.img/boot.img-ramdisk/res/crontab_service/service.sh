#!/system/bin/sh

# Created By Dorimanx and Dairinin

KITKAT=0;
KK_SAMMY=0;
[ -f /system/lib/ssl/engines/libkeystore.so ] && KITKAT=1;
if [ -e /tmp/sammy_rom ]; then
	KK_SAMMY=1;
fi;

# allow custom user jobs
if [ ! -e /data/crontab/root ]; then
	mkdir /data/crontab/;
	cp -a /res/crontab_service/root /data/crontab/;
	chown 0:0 /data/crontab/root;
	chmod 777 /data/crontab/root;
fi;

if [ ! -e /system/etc/cron.d/crontabs/root ]; then
	mkdir -p /system/etc/cron.d/crontabs/;
	cp -a /data/crontab/root /system/etc/cron.d/crontabs/;
	chown 0:0 /system/etc/cron.d/crontabs/*;
	chmod 777 /system/etc/cron.d/crontabs/*;
fi;

if [ ! -e /var/spool/cron/crontabs/root ]; then
	mkdir -p /var/spool/cron/crontabs/;
	cp -a /data/crontab/root /var/spool/cron/crontabs/;
	chown 0:0 /var/spool/cron/crontabs/*;
	chmod 777 /var/spool/cron/crontabs/*;
fi;
echo "root:x:0:0::/var/spool/cron/crontabs:/sbin/sh" > /etc/passwd;

JELLY_MIUI()
{

	echo "root:x:0:0::/system/etc/cron.d/crontabs:/sbin/sh" > /etc/passwd;
}

KK_SAMMY_CRON()
{
	if [ ! -e /var/spool/cron/crontabs/root ]; then
		mkdir -p /var/spool/cron/crontabs/;
		cp -a /data/crontab/root /var/spool/cron/crontabs/;
		chown 0:0 /var/spool/cron/crontabs/*;
		chmod 777 /var/spool/cron/crontabs/*;
	fi;
	echo "root:x:0:0::/var/spool/cron/crontabs:/sbin/sh" > /etc/passwd;
}

if [ "$KK_SAMMY" -eq "1" ]; then
	JB_SAMMY_CRON;
elif [ "$KITKAT" -eq "1" ]; then
	JELLY_MIUI;
else
	KK_SAMMY_CRON;
fi;

# set timezone
TZ=UTC

# set cron timezone
export TZ

#Set Permissions to scripts
chown 0:0 /data/crontab/cron-scripts/*;
chmod 777 /data/crontab/cron-scripts/*;

if [ -e /system/xbin/busybox ] || [ -e /system/bin/busybox ]; then
	if [ "$KK_SAMMY" -eq "1" ]; then
		nohup /system/xbin/busybox crond -c /var/spool/cron/crontabs/
	elif [ "$KITKAT" -eq "1" ]; then
		nohup /system/xbin/busybox crond -c /system/etc/cron.d/crontabs/
	fi;
fi;
