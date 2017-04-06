#!/bin/bash
# ----------------------------------------------------------------------
# OrangePi Configure
# Maintainer: Buddy <buddy.zhang@aliyun.com>
#
# Copyright (C) 2017 OrangePi 
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.

# -------------------------------------------------------
# Base path
ROOT="/usr/local/sbin"

# -----------------------------------------
# Import Global value
# -----------------------------------------
. ${ROOT}/OrangePi_Settings/Import_Envirnoment.sh

SLOOP=1
while [ ${SLOOP} = "1" ]
do 
    # Main Menu
    OPTION=$(whiptail --title "${TITLE}" \
        --menu " " 13 40 7 --cancel-button Exit --ok-button Select \
	        "0"  "Wifi Settings" \
		    "1"  "Audio Settings" \
		    "2"  "Camera Settings" \
		    "3"  "GPIO Settings" \
		    "4"  "Storage Settings" \
		    "5"  "User Settings" \
		    "6"  "Advanced Settings" \
		    3>&1 1>&2 2>&3)

    exitstatus=$?
    if [ ${exitstatus} != 0 ]; then
        clear
        exit 0
    fi

    if [ ${OPTION} = "0" ]; then
        # Wifi settings
        . ${ORANGEPI_WIFI_SETTINGS}
    elif [ ${OPTION} = "1" ]; then
        # Audio settings
        . ${ORANGEPI_AUDIO_SETTINGS}
    elif [ ${OPTION} = "2" ]; then
	    # Camera settings
        . ${ORANGEPI_CAMERA_SETTINGS}
    elif [ ${OPTION} = "3" ]; then
        . ${ORANGEPI_GPIO_SETTINGS}
        echo 0
    elif [ ${OPTION} = "4" ]; then
        . ${ORANGEPI_STORAGE_SETTINGS}
        echo 0
    elif [ ${OPTION} = "5" ]; then
        # . ${UPDATE_CHANGE}
        echo 0
    elif [ ${OPTION} = "6" ]; then
        # . ${EXCHANGE_PROJECT}
        echo 0
    fi
done
