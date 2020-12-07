#!/bin/bash

for DEVICE in `adb devices | grep -v "List" | awk '{print $1}'`
do
    STATE=$(adb -s $DEVICE get-state)
    if [ "$STATE" = "device" ]; then
        MODEL=$(adb -s $DEVICE shell getprop ro.product.model)
        TEMP=$(adb -s $DEVICE shell dumpsys battery | grep temperature | grep -Eo '[0-9]{1,3}')
        if adb -s $DEVICE shell ping -c 1 8.8.8.8 | grep -q rtt; then
            echo $DEVICE $MODEL has a connection to the internet $state and the battery  temperature is $((TEMP / 10)) degrees
        else
            echo $DEVICE $MODEL has no connection to the internet $state and the battery temperature is $((TEMP / 10)) degrees
        fi
    else
        echo $DEVICE state is $STATE
    fi
done