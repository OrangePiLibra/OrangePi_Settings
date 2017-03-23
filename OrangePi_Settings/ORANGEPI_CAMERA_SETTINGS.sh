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

# OrangePi RDA WIFI settings
function OrangePi_RDA_CAMERA_DEVICE()
{
    OPTION=$(whiptail --title "${TITLE}" \
                --menu " " 13 40 2 --cancel-button Exit --ok-button Select \
                "0"  "GC2035" \
                "1"  "GC0309" \
                 3>&1 1>&2 2>&3)
    if [ ${OPTION} = 0 ]; then
        insmod ${CAMERA_DEVICE_PATH}/GC2035.ko
    elif [ ${OPTION} = 1 ]; then
        insmod ${CAMERA_DEVICE_PATH}/GC0309.ko
    fi
}

# OrangePi wifi Setting
function OrangePi_Camera_Setting()
{
    local ip_addr=$(ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:")

    OPTION=$(whiptail --title "${TITLE}" \
            --menu " " 13 40 2 --cancel-button Exit --ok-button Select \
            "0"  "Camera Device Settings" \
            "1"  "Start Motion" \
            3>&1 1>&2 2>&3)
    
    exitstatus=$?
    if [ ${exitstatus} != 0 ]; then
        clear
        exit 0
    fi

    if [ ${OPTION} = 0 ]; then
        if [ ${PLATFORM} = "OrangePi_RDA" ]; then
            OrangePi_RDA_CAMERA_DEVICE
        fi
    elif [ ${OPTION} = 1 ]; then
        /etc/init.d/motion start
        whiptail --title "MessageBox" \
                 --msgbox "Please browse: ${ip_addr}:8081" \
                          10 60
    fi
}


# Utilize 
OrangePi_Camera_Setting
