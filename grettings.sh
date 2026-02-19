#!/bin/bash

USER_NAME=$(whoami)
HOUR=$(date +%H)

if [ $HOUR -ge 5 ] && [ $HOUR -lt 12 ]; then
    echo "Good Morning $USER_NAME!"
elif [ $HOUR -ge 12 ] && [ $HOUR -lt 18 ]; then
    echo "Good Afternoon $USER_NAME!"
else
    echo "Good Evening $USER_NAME!"
fi
