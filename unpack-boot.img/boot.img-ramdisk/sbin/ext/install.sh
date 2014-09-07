#!/system/bin/sh

. /res/customconfig/customconfig-helper;
read_defaults;
read_config;

cd /;

#extract_kernel_payload()
#{
#	chmod 755 /sbin/read_boot_headers;
#	eval $(/sbin/read_boot_headers /dev/block/mmcblk0p5);
#	load_offset=$boot_offset;
#	load_len=$boot_len;
#	cd /;
#	dd bs=512 if=/dev/block/mmcblk0p5 skip=$load_offset count=$load_len | xzcat | tar x;
#}
#extract_kernel_payload; #disabled


#extract_payload()
#{
#	cd /res/misc/payload/;
#	$BB xzcat SuperSU.apk.tar.xz > SuperSU.apk.tar;
#	$BB xzcat su.tar.xz > su.tar;
#	$BB tar -xvf SuperSU.apk.tar;
#	$BB tar -xvf su.tar;
#	cd /;
#}
#extract_payload; #disabled

# copy cron files
if [ ! -e /data/crontab ]; then
/sbin/busybox cp -a /res/crontab/ /data/
/sbin/busybox rm -rf /data/crontab/cron/ > /dev/null 2>&1;
if [ ! -e /data/crontab/custom_jobs ]; then
/sbin/busybox touch /data/crontab/custom_jobs;
/sbin/busybox chmod 777 /data/crontab/custom_jobs;
fi;

if [ ! -e /system/etc/cron.d/crontabs/root ]; then
/sbin/busybox mkdir -p /system/etc/cron.d/crontabs/;
/sbin/busybox cp -a /data/crontab/root /system/etc/cron.d/crontabs/;
/sbin/busybox chown 0:0 /system/etc/cron.d/crontabs/*;
/sbin/busybox chmod 777 /system/etc/cron.d/crontabs/*;
fi;

# copy sqlite
/sbin/busybox cp -a /res/misc/sql/libsqlite.so /system/lib/libsqlite.so;
/sbin/busybox cp -a /res/misc/sql/sqlite3 /system/xbin/sqlite3;
/sbin/busybox chmod 644 /system/lib/libsqlite.so;
/sbin/busybox chmod 755 /system/xbin/sqlite3;
/sbin/busybox rm -f /res/misc/sql/;

/sbin/busybox mount -o remount,rw /;
/sbin/busybox mount -o remount,rw /system;
