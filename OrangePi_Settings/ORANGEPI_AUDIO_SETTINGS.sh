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

# Audio Play on RDA
function OrangePi_RDA_Audio_Play() 
{
    amixer cset numid=9,iface=MIXER,name='Stop' 1
    amixer cset numid=2,iface=MIXER,name='InChannelNumber' 1
    amixer cset numid=2,iface=MIXER,name='InSampleRate' 8000
    amixer cset numid=2,iface=MIXER,name='Capture Volume' 2
    amixer cset numid=1,iface=MIXER,name='Playback Volume' 7
    amixer cset numid=10,iface=MIXER,name='OutSampleRate' 44100
    amixer cset numid=11,iface=MIXER,name='OutChannelNumber' 2
    amixer cset numid=6,iface=MIXER,name='CodecAppMode' 0
    amixer cset numid=7,iface=MIXER,name='StartPlay' 1
    amixer cset numid=3,iface=MIXER,name='ITF' $1
    amixer cset numid=4,iface=MIXER,name='SpkSel' 2
    amixer cset numid=5,iface=MIXER,name='ForceMainMic' 0
    amixer cset numid=15,iface=MIXER,name='Commit Setup' 0
}

# Audio Record on RDA
function OrangePi_RDA_Audio_Record()
{
    amixer cset numid=9,iface=MIXER,name='Stop' 1
    amixer cset numid=2,iface=MIXER,name='Capture Volume' 2
    amixer cset numid=3,iface=MIXER,name='ITF' $1
    amixer cset numid=5,iface=MIXER,name='ForceMainMic' 1
    amixer cset numid=6,iface=MIXER,name='CodecAppMode' 0
    amixer cset numid=12,iface=MIXER,name='InSampleRate' 16000
    amixer cset numid=13,iface=MIXER,name='InChannelNumber' 1
    amixer cset numid=8,iface=MIXER,name='StartRecord' 1
}

function OrangePi_RDA_Audio_ChangeVolume()
{
    # Record
    if [ $1 = 0 ]; then
        amixer cset numid=2,iface=MIXER,name='Capture Volume' $2
    # Play
    elif [ $1 = 1 ]; then
        amixer cset numid=1,iface=MIXER,name='Playback Volume' $2
    fi    
    amixer cset numid=15,iface=MIXER,name='Commit Setup' 0
}

# Audio Setting for RDA
function OrangePi_RDA_Audio_Settings()
{

    OPTION=$(whiptail --title "${TITLE}" \
        --menu " " 13 40 4 --cancel-button Exit --ok-button Select \
            "0"  "Player Option" \
            "1"  "Record Option" \
            "2"  "Testing Option" \
            "3"  "Volume Option" \
            3>&1 1>&2 2>&3)

    exitstatus=$?
    if [ ${exitstatus} != 0 ]; then
        clear
        exit 0
    fi

    if [ ${OPTION} = "0" ]; then
         _OPTION=$(whiptail --title "${TITLE}" \
                 --menu " " 13 40 2 --cancel-button Exit --ok-button Select \
                 "0"  "Play with Main Speaker" \
                 "1"  "Play with Headphone" \
                 3>&1 1>&2 2>&3)
        if [ ${_OPTION} = 0 ]; then
            OrangePi_RDA_Audio_Play "2"
        elif [ ${_OPTION} = 1 ]; then
            OrangePi_RDA_Audio_Play "1"
        fi
    elif [ ${OPTION} = "1" ]; then
         _OPTION=$(whiptail --title "${TITLE}" \
                 --menu " " 13 40 2 --cancel-button Exit --ok-button Select \
                 "0"  "Record with Main MIC" \
                 "1"  "Record with Headphone" \
                 3>&1 1>&2 2>&3)
        if [ ${_OPTION} = 0 ]; then
            OrangePi_RDA_Audio_Record "2"
        elif [ ${_OPTION} = 1 ]; then
            OrangePi_RDA_Audio_Record "1"
        fi

    elif [ ${OPTION} = "2" ]; then
         _OPTION=$(whiptail --title "${TITLE}" \
                 --menu " " 13 40 2 --cancel-button Exit --ok-button Select \
                 "0"  "Testing Main Speaker" \
                 "1"  "Testing Headphone" \
                 3>&1 1>&2 2>&3)
        if [ ${_OPTION} = 0 ]; then
            OrangePi_RDA_Audio_Play "2"
            aplay ${TESTING_AUDIO}
        elif [ ${_OPTION} = 1 ]; then
            OrangePi_RDA_Audio_Play "1"
            aplay ${TESTING_AUDIO}
        fi
    elif [ ${OPTION} = "3" ]; then
         _OPTION=$(whiptail --title "${TITLE}" \
                 --menu " " 13 40 2 --cancel-button Exit --ok-button Select \
                 "0"  "Change Capture Volume" \
                 "1"  "Change Playback Volume" \
                 3>&1 1>&2 2>&3)
         _VOLUME=$(whiptail --title "Input Box" \
                        --inputbox "Please Input Volume(1~8)" 10 60 \
                                        3>&1 1>&2 2>&3)
        if [ ${_OPTION} = 0 ]; then
            OrangePi_RDA_Audio_ChangeVolume "0" ${_VOLUME}
        elif [ ${_OPTION} = 1 ]; then
            OrangePi_RDA_Audio_ChangeVolume "1" ${_VOLUME}
        fi
        
    fi

    whiptail --title "MessageBox" \
         --msgbox "Play Audio: aplay Aduio.wav                          Record: arecord -d 10 -t wav Audio.wav" \
                  10 60

}

# ---------------------------------------------------------------
# H5 Audio
# ---------------------------------------------------------------
# Play
function OrangePi_H5_PlayAudio()
{
    AUDIO_PATH=$(whiptail --title "${TITLE}" \
                          --inputbox "Please input path of wav file and plug headphone!" 10 60 \
                          3>&1 1>&2 2>&3)    
    aplay ${AUDIO_PATH}
}

# Record 
function OrangePi_H5_Record()
{
    AUDIO_PATH=$(whiptail --title "${TITLE}" \
                          --inputbox "Please input audio name and point to main MIC!" 10 60 \
                                                        3>&1 1>&2 2>&3)   
    AUDIO_TIME=$(whiptail --title "${TITLE}" \
                          --inputbox "Please input record time" 10 60 \
                                                        3>&1 1>&2 2>&3)   
    arecord -d ${AUDIO_TIME} -f cd -t wav ${AUDIO_PATH}
}

function OrangePi_H5_AudioTesting()
{
    if [ $1 = 0 ]; then
        aplay /usr/local/sbin/TestAudio.wav
    elif [ $1 = 1 ]; then
        arecord -d 3 -t wav -f cd tmp.wav
        aplay tmp.wav
        rm -rf tmp.wav
    fi    
}

# Set volume
function OrangePi_Set_Volume()
{
    echo "SB"    
}

function OrangePi_H5_Audio_Settings()
{
    OPTION=$(whiptail --title "${TITLE}" \
        --menu " " 13 40 4 --cancel-button Exit --ok-button Select \
            "0"  "Player Settings" \
            "1"  "Record Settings" \
            "2"  "Testing Settings" \
            "3"  "Volume Settings" \
            3>&1 1>&2 2>&3)

    exitstatus=$?
    if [ ${exitstatus} != 0 ]; then
        clear
        exit 0
    fi
    
    if [ ${OPTION} = 0 ]; then
         _OPTION=$(whiptail --title "${TITLE}" \
                 --menu " " 13 40 2 --cancel-button Exit --ok-button Select \
                 "0"  "Play with Headphone" \
                 "1"  "Play Sound" \
                 3>&1 1>&2 2>&3)
         
         if [ ${_OPTION} = 1 ]; then
            OrangePi_H5_PlayAudio
         fi
    elif [ ${OPTION} = 1 ]; then
         _OPTION=$(whiptail --title "${TITLE}" \
                 --menu " " 13 40 2 --cancel-button Exit --ok-button Select \
                 "0"  "Record with Main MIC" \
                 "1"  "Record Sound" \
                 3>&1 1>&2 2>&3)
         if [ ${_OPTION} = 1 ]; then
            OrangePi_H5_Record  
         fi
    elif [ ${OPTION} = 2 ]; then
         _OPTION=$(whiptail --title "${TITLE}" \
                 --menu " " 13 40 2 --cancel-button Exit --ok-button Select \
                 "0"  "Testing Play" \
                 "1"  "Testing Record" \
                 3>&1 1>&2 2>&3)
        OrangePi_H5_AudioTesting ${_OPTION}
    elif [ ${OPTION} = 3 ]; then
        OrangePi_Set_Volume
    fi
}

# Utilize 
if [ ${PLATFORM} = "OrangePi_RDA" ]; then
    OrangePi_RDA_Audio_Settings
elif [ ${PLATFORM} = "OrangePi_H5_ZeroPlus2" ]; then
    OrangePi_H5_Audio_Settings
fi
