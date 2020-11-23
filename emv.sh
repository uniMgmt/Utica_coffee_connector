#!/bin/bash
#************************************
#*  Bank of Utica Coffe EMV reader  *
#* Rev 0.2 Upstate Networks Inc     *
#************************************
printf "EMV reader rev 0.2 %b\n"
printf "Copyright Upstate Networks Inc 2020 %b\n"
#**************************************
#*   Auto detect Card reader          *
#*  Looking for "Cherry" from GmbH    *
#*  Loop forever until found          *
#**************************************
# LEDs= Device Status, Good card read, Error, MISC

a="$(lsusb | grep Cherry)"
echo $a
reader=""
echo "************"
reader="$(lsusb | grep Cherry)"
echo "Searching for EMV card reader"
while [ -z "$reader" ]
  do
    echo "EMV Card Reader not found.  Check connection"
    reader="$(lsusb | grep Cherry)"
    sleep 3
    #Blink status LED
done
echo "Card Reader Found: " $reader

echo "Coffee disabled, waiting for card insertion"
#Loop waiting for card insertion
 b="$(pcsc_scan | grep Bank)"
echo $b
while [ -z "$b" ]
  do
    echo "Waiting for card insertion"
    b="$(pcsc_scan)"
    #sleep 1
    #Blink ready LED
  done

  echo "Coffee ready, please insert and lower lid"


#while lsusb | grep Bank =/= null

    #check BID
    #Enable GPIO
    #enable other LEDs
#end while

#Log success