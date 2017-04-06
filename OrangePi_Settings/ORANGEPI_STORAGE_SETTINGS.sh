#!/bin/bash
# ----------------------------------------------------------------------
# OrangePi WIFI Settings
# Maintainer: Buddy <buddy.zhang@aliyun.com>
#
# Copyright (C) 2017 OrangePi 
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.

# ----------------------------------------------
# Storage Settins
# ----------------------------------------------
function OrangePi_Storage_MENU()
{

    OPTION=$(whiptail --title "${TITLE}" \
        --menu " " 13 40 4 --cancel-button Exit --ok-button Select \
            "0"  "Formate EMMC as Normal Storage(SDcard boot mode)" \
            "1"  "Expand SD card(SDcard boot mode)" \
            "2"  "Install Image into EMMC(SDcard boot mode)" \
            3>&1 1>&2 2>&3)

    exitstatus=$?
    if [ ${exitstatus} != 0 ]; then
        clear
        exit 0
    fi

    if [ ${OPTION} = "0" ]; then
        if [ ! -b /dev/mmcblk1 ]; then
            whiptail --title "${TITLE}" \
                    --msgbox "ERROR! can't operate on SDcard mode" \
                                                     10 60
        fi
        . /usr/local/sbin/OrangePi_FormatEMMC.sh
        if [ ! -d /media/EMMC ]; then
            mkdir -p /media/EMMC
        fi
cat > "/etc/fstab" <<EOF
# OrangePi fstable
# <file system> <dir>   <type>  <options>           <dump>  <pass>
/dev/mmcblk1p1  /boot   vfat    defaults            0       2
/dev/mmcblk1p2  /   ext4    defaults,noatime        0       1
/dev/mmcblk0p2  /media/EMMC ext4 defaults,noatime        0       1
EOF
        reboot 
    elif [ ${OPTION} = "1" ]; then
        if [ ! -b /dev/mmcblk1 ]; then
            whiptail --title "${TITLE}" \
                    --msgbox "ERROR! can't operate on SDcard mode" \
                                                     10 60
        fi
        #./usr/local/sbin/OrangePi_Resize_rootfs.sh
        #reboot
    elif [ ${OPTION} = "2" ]; then
        if [ ! -b /dev/mmcblk1 ]; then
            whiptail --title "${TITLE}" \
                    --msgbox "ERROR! can't operate on SDcard mode" \
                                                     10 60
        fi
        . /usr/local/sbin/OrangePi_Install_OrangePi_2_EMMC.sh
        reboot
    fi
}


# Utilize 
if [ ${PLATFORM} = "OrangePi_RDA" ]; then
    echo ""
elif [ ${PLATFORM} = "OrangePi_H5_ZeroPlus2" ]; then
    OrangePi_Storage_MENU
fi
