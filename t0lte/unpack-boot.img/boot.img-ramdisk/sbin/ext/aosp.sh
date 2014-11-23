#!/system/bin/sh

. /res/customconfig/customconfig-helper;
read_defaults;
read_config;

cd /;

# copy new sensors
rm -rf /system/bin/sensorservice;
rm -rf /system/lib/hw/sensors.smdk4x12.so;
cp -a /res/misc/sensors/sensorhubservice /system/bin/sensorhubservice;
cp -a /res/misc/sensors/libsensorhubservice.so /system/lib/libsensorhubservice.so;
cp -a /res/misc/sensors/sensorhubs.smdk4x12.so /system/lib/hw/sensorhubs.smdk4x12.so;
cp -a /res/misc/sensors/sensors.smdk4x12.so /system/lib/hw/sensors.smdk4x12.so;
rm -rf /res/misc/sensors;

# Install stereo sound mod and Incall volume FIX
rm -rf /system/etc/sound/tiny_hw.xml;
cp -a /res/misc/tiny_hw.xml /system/etc/sound/tiny_hw.xml;
rm -rf /res/misc/tiny_hw.xml;

mount -o remount,rw /;
mount -o remount,rw /system;
