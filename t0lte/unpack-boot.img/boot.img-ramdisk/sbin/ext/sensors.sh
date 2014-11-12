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

# copy new sensors
rm -rf /system/bin/sensorservice;
rm -rf /system/lib/hw/sensors.smdk4x12.so;
cp -a /res/misc/sensors/sensorhubservice /system/bin/sensorhubservice;
cp -a /res/misc/sensors/libsensorhubservice.so /system/lib/libsensorhubservice.so;
cp -a /res/misc/sensors/sensorhubs.smdk4x12.so /system/lib/hw/sensorhubs.smdk4x12.so;
cp -a /res/misc/sensors/sensors.smdk4x12.so /system/lib/hw/sensors.smdk4x12.so;
rm -rf /res/misc/sensors;

mount -o remount,rw /;
mount -o remount,rw /system;
