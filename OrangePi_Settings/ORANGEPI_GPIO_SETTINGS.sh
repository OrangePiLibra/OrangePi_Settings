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
# GPIO Settins
# ----------------------------------------------
function OrangePi_GPIO_MENU()
{

    OPTION=$(whiptail --title "${TITLE}" \
        --menu " " 13 40 4 --cancel-button Exit --ok-button Select \
            "0"  "GPIO Information" \
            "1"  "LED Settings" \
            "2"  "GPIO Settings details" \
            3>&1 1>&2 2>&3)

    exitstatus=$?
    if [ ${exitstatus} != 0 ]; then
        clear
        exit 0
    fi

    if [ ${OPTION} = "0" ]; then
        ls /sys/class/gpio_sw > .tmp
        whiptail --textbox --scrolltext .tmp 12 60
        rm .tmp
    elif [ ${OPTION} = "1" ]; then
         _OPTION=$(whiptail --title "${TITLE}" \
                 --menu " " 13 40 2 --cancel-button Exit --ok-button Select \
                 "0"  "Power Status LED" \
                 "1"  "Standby LED" \
                 3>&1 1>&2 2>&3)

         _sloop=1
        while [ ${_sloop} = "1" ]
        do
            _BOPTION=$(whiptail --title "${TITLE}" \
                 --menu " " 13 40 2 --cancel-button Exit --ok-button Select \
                 "0"  "OFF" \
                 "1"  "ON" \
                 3>&1 1>&2 2>&3)
            exitstatus=$?
            if [ ${exitstatus} != 0 ]; then
                _sloop=0
            fi
            if [ ${_OPTION} = 0 ]; then
                echo ${_BOPTION} > /sys/class/gpio_sw/normal_led/data 
            elif [ ${_OPTION} = 1 ]; then
                echo ${_BOPTION} > /sys/class/gpio_sw/standby_led/data 
            fi

        done

    elif [ ${OPTION} = "2" ]; then
        GPIO_NAME=$(whiptail --title "${TITLE}" \
                  --inputbox "Please input CPIO name" 10 60 \
                  3>&1 1>&2 2>&3)
        if [ ! -d /sys/class/gpio_sw/${GPIO_NAME} ]; then
            whiptail --title "${TITLE}" \
                     --msgbox "${GPIO_NAME} doesn't exist!" \
                        10 60
        else
            whiptail --title "${TITLE}" \
                     --msgbox "More GPIO information, please entry /sys/class/gpio_sw/${GPIO_NAME}" \
                        10 60
        fi
    fi
}


# Utilize 
if [ ${PLATFORM} = "OrangePi_RDA" ]; then
    echo ""
elif [ ${PLATFORM} = "OrangePi_H5_ZeroPlus2" ]; then
    OrangePi_GPIO_MENU
fi
