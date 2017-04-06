#!/bin/bash
set -e
# ----------------------------------------------------------------------
# Install scripts
# Maintainer: Buddy <buddy.zhang@aliyun.com>
#
# Copyright (C) 2017 BiscuitOS
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.

# ----------------------------------------------
# Path for installing
# ----------------------------------------------
INSTALL_PATH=/usr/local/sbin/OrangePi_Settings

# ----------------------------------------------
# Path of configure file
# ----------------------------------------------
CONFIG_PATH=/etc/OrangePi_Settings

# ----------------------------------------------
# Name of configure
# ----------------------------------------------
CONFIG_NAME=OrangePi_Settings.conf

# ----------------------------------------------
# Path of bin
# ----------------------------------------------
BIN_PATH=/usr/bin

# ----------------------------------------------
# Name of bin
# ----------------------------------------------
BIN_NAME=OrangePi_Settings

# ----------------------------------------------
# Main file
# ----------------------------------------------
MAIN_FILE=OrangePi-config.sh

# -----------------------------------------------
# Main dirent
# -----------------------------------------------
MAIN_DIRENT=OrangePi_Settings

# -----------------------------------------------
# Local configure file
# -----------------------------------------------
LOCAL_CONFIG_FILE=Import_Envirnoment.sh

ROOT=`pwd`

# Platform 
if [ -z $1 ]; then
    echo "Please add plaform, as"
    echo "./INSTALL.sh OrangePi_PC2" 
    exit 0 
else
    if [ ! -d ${INSTALL_PATH} ]; then
        mkdir -p ${INSTALL_PATH}
    fi
    echo $1 > ${INSTALL_PATH}/VERSION
fi 

# File check
if [ ! -f ${ROOT}/${MAIN_FILE} ]; then
    echo "Abort! Losing ${MAIN_FILE}"
    exit 0
fi

if [ ! -d ${ROOT}/${MAIN_DIRENT} ]; then
    echo "Abort! Losing ${MAIN_DIRENT}"
fi

# Install
if [ ! -d ${INSTALL_PATH} ]; then
    mkdir -p ${INSTALL_PATH}
fi

if [ ! -d ${CONFIG_PATH} ]; then
    mkdir -p ${CONFIG_PATH}
fi

install ${MAIN_FILE} ${INSTALL_PATH}
install ${MAIN_DIRENT}/*    ${INSTALL_PATH}

# Create link
if [ ! -f ${CONFIG_PATH}/${CONFIG_NAME} ]; then
    ln -s ${INSTALL_PATH}/${LOCAL_CONFIG_FILE} ${CONFIG_PATH}/${CONFIG_NAME} 
fi
if [ ! -f ${BIN_PATH}/${BIN_NAME} ]; then
    ln -s ${INSTALL_PATH}/${MAIN_FILE} ${BIN_PATH}/${BIN_NAME} 
fi

