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


    if [ -f ${_CONFIG_FILE} ]; then
        _SSID=`cat ${_CONFIG_FILE} | grep "ssid"`
        if [ ! -z ${_SSID} ]; then
            if (whiptail --title "${TITLE}" --yes-button "OK" --no-button "NO" --yesno "${_SSID} has exist! Do you want to connect this AP?" 10 60) then
                exit 0
            fi
        fi
    fi

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

# Utilize 
if [ ${PLATFORM} = "OrangePi_RDA" ]; then
    OrangePi_RDA_WIFI
fi
