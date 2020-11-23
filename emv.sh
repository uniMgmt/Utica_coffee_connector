#!/bin/bash
#************************************
#*  Bank of Utica Coffe EMV reader  *
#* Rev 0.4 Upstate Networks Inc     *
#************************************
printf "EMV reader rev 0.2 %b\n"
printf "Copyright Upstate Networks Inc 2020 %b\n"
#**************************************
#*   Auto detect Card reader          *
#*  Looking for "Cherry" from GmbH    *
#*  Loop forever until found          *
#**************************************
# LEDs= Device Status, Good card read, Error, MISC
#Rev 3: main loop strings from scriptor
while :
do
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
  echo RESET | scriptor 
 
  b="$(echo RESET | scriptor)"
  echo $b
  while [ -z "$b" ]
    do
      echo "Waiting for card insertion"
      #sleep 1
      b="$(echo RESET | scriptor)"
      echo $b
      #sleep 1
      #Blink ready LED
  done

  echo "Coffee ready, please insert and lower lid"
    #check BID
    #Enable GPIO
    #enable other LEDs

    sleep 10
    #reset system for next user

#end while
done
#Log success