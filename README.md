# coffee_bank
From an initial LSUSB on Raspian with a Cherry ST-1144 connected to a USB port

EVM Card Reader to Keurig Coffee Dispenser
Bus 001 Device 004: ID 046a:00a7 Cherry GmbH
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x046a Cherry GmbH
  idProduct          0x00a7
  bcdDevice            1.03
  iManufacturer           1
  iProduct                2
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x005d
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass        11 Chip/SmartCard
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              2
      ChipCard Interface Descriptor:
        bLength                54
        bDescriptorType        33
        bcdCCID              1.10  (Warning: Only accurate for version 1.0)
        nMaxSlotIndex           0
        bVoltageSupport         7  5.0V 3.0V 1.8V
        dwProtocols             3  T=0 T=1
        dwDefaultClock       4800
        dwMaxiumumClock      8000
        bNumClockSupported      4
        dwDataRate          10752 bps
        dwMaxDataRate      412903 bps
        bNumDataRatesSupp.     96
        dwMaxIFSD             254
        dwSyncProtocols  00000007  2-wire 3-wire I2C
        dwMechanical     00000000
        dwFeatures       000407B8
          Auto voltage selection
          Auto clock change
          Auto baud rate change
          Auto PPS made by CCID
          CCID can set ICC in clock stop mode
          NAD value other than 0x00 accepted
          Auto IFSD exchange
          Short and extended APDU level exchange
        dwMaxCCIDMsgLen       271
        bClassGetResponse    echo
        bClassEnvelope       echo
        wlcdLayout           none
        bPINSupport             3  verification modification
        bMaxCCIDBusySlots       1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              24
