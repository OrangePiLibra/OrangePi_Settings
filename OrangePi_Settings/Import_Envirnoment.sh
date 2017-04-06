#!/bin/bash
# ----------------------------------------------------------------------
# OrangePi Global Value
# Maintainer: Buddy <buddy.zhang@aliyun.com>
#
# Copyright (C) 2017 OrangePi 
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.

# ------------------------------------------
# ROOT Path
# ------------------------------------------
ROOT="/usr/local/sbin"

# ------------------------------------------
# Local path for configure file
# ------------------------------------------
SETTINGS_PATH=${ROOT}/OrangePi_Settings

# ------------------------------------------
# Vendor Settings
# ------------------------------------------
VENDOR="OrangePi"

# ------------------------------------------
# Platform
# ------------------------------------------
PLATFORM_VERSION=${SETTINGS_PATH}/VERSION
PLATFORM=$(cat ${PLATFORM_VERSION})

# ------------------------------------------
# Menu Title
# ------------------------------------------
TITLE="OrangePi Settings"

# ------------------------------------------
# Testing Auido file
# ------------------------------------------
TESTING_AUDIO=/usr/local/sbin/TestAudio.wav

# ------------------------------------------
#
# ------------------------------------------
CAMERA_DEVICE_PATH=/lib/modules/$(uname -r)/kernel

# ------------------------------------------
# Path scripts
# ------------------------------------------
ORANGEPI_WIFI_SETTINGS=${SETTINGS_PATH}/ORANGEPI_WIFI_SETTINGS.sh
ORANGEPI_AUDIO_SETTINGS=${SETTINGS_PATH}/ORANGEPI_AUDIO_SETTINGS.sh
ORANGEPI_CAMERA_SETTINGS=${SETTINGS_PATH}/ORANGEPI_CAMERA_SETTINGS.sh
ORANGEPI_GPIO_SETTINGS=${SETTINGS_PATH}/ORANGEPI_GPIO_SETTINGS.sh
ORANGEPI_STORAGE_SETTINGS=${SETTINGS_PATH}/ORANGEPI_STORAGE_SETTINGS.sh
