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

# ---------------------------------------------
# OrangePi RDA Camera
# ---------------------------------------------
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

# ----------------------------------------------
# OrangePi H5 Camera
# ----------------------------------------------
function OrangePi_H5_CAMERA_DEVICE()
{
    CAMERA_CONFIG=/etc/modules-load.d/CAMERA.conf

    OPTION=$(whiptail --title "${TITLE}" \
                      --menu " " 13 40 1 --cancel-button Exit --ok-button Select \
                      "0"  "GC2035" \
                      3>&1 1>&2 2>&3)    
    if [ ${OPTION} = 0 ]; then
        modprobe gc2035
        modprobe vfe_v4l2
# Create wifi configure
cat > "${CAMERA_CONFIG}" <<EOF
#OrangePi Camera Load module
videobuf2-core
videobuf2-memops
videobuf2-dma-contig
vfe_io
gc2035
vfe_v4l2
EOF
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
        elif [ ${PLATFORM} = "OrangePi_H5_ZeroPlus2" ]; then
            OrangePi_H5_CAMERA_DEVICE
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
