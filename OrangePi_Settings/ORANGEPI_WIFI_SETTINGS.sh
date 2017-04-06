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
function OrangePi_RDA_WIFI()
{
    local _WIFI_AP
    local _WIFI_PSD
    local _CONFIG_FILE=/etc/network/interfaces

    _WIFI_AP=$(whiptail --title "${TITLE}" \
                       --inputbox "Please input AP name" 10 60 \
                       3>&1 1>&2 2>&3)
    _WIFI_PSD=$(whiptail --title "${TITLE}" \
                       --inputbox "Please input AP password" 10 60 \
                       3>&1 1>&2 2>&3)

    # Create wifi configure
cat > "${_CONFIG_FILE}" <<EOF
# interfaces(5) file used by ifup(8) and ifdown(8)
# Include files from /etc/network/interfaces.d:
# source-directory /etc/network/interfaces.d

auto wlan0
iface wlan0 inet dhcp
wpa-ssid ${_WIFI_AP}
wpa-psk ${_WIFI_PSD}
EOF

    whiptail --title "${TITLE}" \
             --msgbox "Successful! Please reboot system!" \
                  10 60
}

# OrangePi wifi Setting
function OrangePi_WIFI_Setting()
{
    OPTION=$(whiptail --title "${TITLE}" \
            --menu " " 13 40 3 --cancel-button Exit --ok-button Select \
            "0"  "Scanning WIFI AP" \
            "1"  "Connect New AP" \
            "2"  "Current WIFI info" \
            3>&1 1>&2 2>&3)
    
    exitstatus=$?
    if [ ${exitstatus} != 0 ]; then
        clear
        exit 0
    fi

    if [ ${OPTION} = 0 ]; then
        iw wlan0 scan > .tmp
        whiptail --textbox --scrolltext .tmp 12 60
        rm .tmp
    elif [ ${OPTION} = 1 ]; then
        if [ ${PLATFORM} = "OrangePi_RDA" ]; then
            OrangePi_RDA_WIFI
        elif [ ${PLATFORM} = "OrangePi_H5_ZeroPlus2" ]; then
            OrangePi_RDA_WIFI
        fi
    elif [ ${OPTION} = 2 ]; then
        iw wlan0 info > .tmp
        whiptail --textbox --scrolltext .tmp 12 60
        rm .tmp
    fi
}

# source-directory /etc/network/interfaces.d

# utilize 
OrangePi_WIFI_Setting
