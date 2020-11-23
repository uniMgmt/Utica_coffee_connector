Using a Cherry ST-1144 and requiring CCID & PCSC and writted for a Debian OS.

Testing for Cardreader using emv.sh
**to capture the answer to RESET**
pcsc_scan |grep --line-buffered -i ATR: > log.txt


Compile:
g++ -std=c++0x PCSC.cpp -o pcsc

Enabling coffee maker (Keurig) when proper Bank ID detected using coffee.cpp

Installation instructions

Protocol Documents: ISO 781

**Installation Instructions**
from: https://www.mutek.com/mutek-pcsc-readers-pcsc-lite-linux/

sudo apt-get install libusb-dev libusb++
sudo apt-get install libccid
sudo apt-get install pcscd
sudo apt-get install libpcsclite1
sudo apt-get install libpcsclite-dev
sudo apt-get install libpcsc-perl
sudo apt-get install pcsc-tools
sudo apt-get update

**Testing Installation**

lsusb | grep Cherry
Returns: Bus 001 Device 016: ID 046a:00a7 Cherry GmbH

pcsc_scan
Returns:Using reader plug'n play mechanism
Scanning present readers...
0: Cherry SmartTerminal XX44 [Smart Terminal XX44] 00 00

Sun Nov 22 21:03:51 2020
 Reader 0: Cherry SmartTerminal XX44 [Smart Terminal XX44] 00 00
  Event number: 0
  Card state: Card removed,
ANd With card:
Sun Nov 22 21:04:32 2020
 Reader 0: Cherry SmartTerminal XX44 [Smart Terminal XX44] 00 00
  Event number: 1
  Card state: Card inserted,
  ATR: 3B 6D 00 00 80 31 80 65 B0 89 35 01 F1 83 00 90 00

ATR: 3B 6D 00 00 80 31 80 65 B0 89 35 01 F1 83 00 90 00
+ TS = 3B --> Direct Convention
+ T0 = 6D, Y(1): 0110, K: 13 (historical bytes)
  TB(1) = 00 --> VPP is not electrically connected
  TC(1) = 00 --> Extra guard time: 0
+ Historical bytes: 80 31 80 65 B0 89 35 01 F1 83 00 90 00
  Category indicator byte: 80 (compact TLV data object)
    Tag: 3, len: 1 (card service data byte)
      Card service data byte: 80
        - Application selection: by full DF name
        - EF.DIR and EF.ATR access services: by GET RECORD(s) command
        - Card with MF
    Tag: 6, len: 5 (pre-issuing data)
      Data: B0 89 35 01 F1
    Tag: 8, len: 3 (status indicator)
      LCS (life card cycle): 00 (No information given)
      SW: 9000 (Normal processing.)

Possibly identified card (using /usr/share/pcsc/smartcard_list.txt):
3B 6D 00 00 80 31 80 65 B0 89 35 01 F1 83 00 90 00
        Bank of America BankAmericard Travel Visa Chip Card (Gemalto)
        https://www.bankofamerica.com/credit-cards/products/bankamericard-travel-rewards-credit-card.go
        Credito Trevigiano - Banca di Credito Cooperativo - Carta BCC
        VISA Signature issued by RBC Bank (Georgia), N.A.
        https://www.rbcbank.com/
        Banca Popolare di Novara - (Bancomat Maestro)
