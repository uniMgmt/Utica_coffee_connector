#!/bin/bash
#************************************
#*  Bank of Utica Coffe EMV reader  *
#* Rev 0.6 Upstate Networks Inc     *
#************************************
printf "EMV reader rev 0.8 %b\n"
printf "Copyright Upstate Networks Inc 2020 %b\n"
#**************************************
#*   Auto detect Card reader          *
#*  Looking for "Cherry" from GmbH    *
#*  Loop forever until found          *
#**************************************
# LEDs= Device Status, Good card read, Error, MISC
#Rev 3: main loop strings from scriptor
#Rev 5 added GPIO lines
#Rev 6 adds three GPIO lines and handles ctrl-c on exit
#Rev 7 interrogates ICC for BoU BIC
#      ICC=Integrated Ciruit Card (bank card)
#      BoU=Bank of Utica
#      BIC=Bank Identifier Code
#      APDU=Application Protocol Data Unit
#      SW1/2=Status Byte 1 or 2 repsectively
#Rev 8 Distinguishes between BoU card and others but needs BIC better defined

# Common path for all GPIO access
BASE_GPIO_PATH=/sys/class/gpio

# Assign names to GPIO pin numbers for each light
RED=5
YELLOW=6
GREEN=13

# Assign names to states
ON="1"
OFF="0"

# Utility function to export a pin if not already exported
exportPin()
{
  if [ ! -e $BASE_GPIO_PATH/gpio$1 ]; then
    echo "$1" > $BASE_GPIO_PATH/export
  fi
}

# Utility function to set a pin as an output
setOutput()
{
  echo "out" > $BASE_GPIO_PATH/gpio$1/direction
}

# Utility function to change state of a light
setLightState()
{
  echo $2 > $BASE_GPIO_PATH/gpio$1/value
}

# Utility function to turn all lights off
allLightsOff()
{
  setLightState $RED $OFF
  setLightState $YELLOW $OFF
  setLightState $GREEN $OFF
}

# Utility function to turn all lights on
allLightsOn()
{
  setLightState $RED $ON
  setLightState $YELLOW $ON
  setLightState $GREEN $ON
}


# Ctrl-C handler for clean shutdown
shutdown()
{
  allLightsOff
  printf '\n%s\n' 'Clean Exit...'
  exit 0
}

trap shutdown SIGINT

# Export pins so that we can use them
exportPin $RED
exportPin $YELLOW
exportPin $GREEN

# Set pins as outputs
setOutput $RED
setOutput $YELLOW
setOutput $GREEN

# Turn lights off to begin
allLightsOff
allLightsOn
sleep 2
allLightsOff

 

while :
do
  allLightsOff  
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
        setLightState $RED $ON
    done
  echo "Card Reader Found: " $reader
 
  echo "Coffee disabled, waiting for card insertion"
  #Loop waiting for card insertion
  echo RESET | scriptor 
 
  b="$(echo RESET | scriptor)"
  # echo $b
  while [ -z "$b" ]
  
    do
      setLightState $YELLOW $OFF
      setLightState $RED $ON
      echo "Waiting for card insertion"
      sleep .5
      b="$(echo RESET | scriptor)"
      #echo $b
      setLightState $RED $OFF
      sleep .5
  done

  
  echo "Found Card, check if BIC matches"
    #check BID
    setLightState $YELLOW $ON
    sleep 2
    #reset system for next user
    echo "Interrogating ICC for BoU BIC"
    # echo 00 A4 04 00 | scriptor
    c="$(echo 00 A4 04 00 | scriptor)"
    #echo $c
    #echo 00 A4 04 00 67 | scriptor
    c="$(echo 00 A4 04 00 67 | scriptor)"
    echo "This is from scriptor and is string c"
    echo "******************************"
    echo $c
    echo "******************************"
    #BoU BIC is: 12 91 11 11 01 00 but I think there is a cr/lf screwing this up
    d='12 91 11'
    echo $d
   if [[ "$c" =~ .*"$d".* ]]; then
      echo "Found bank of Utica Card"
      echo  -e "\033[33;5;7mCoffee ready, please insert and lower lid\033[0m"
      setLightState $GREEN $ON
      sleep 2
      else
        echo "BIC does not match: foreign card"
    fi


#end while
done
#Log success
