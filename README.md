[[ru]](./README-ru.md)
[[en]](./README.md)

# LogicBox PLC host software

The repository contains software for configuration and control of
LogicBox series Programmable Logic Controllers.  The LogicBox Modular
PLC line is produced by [LLC Elektroprivod NPC IT](http://it-npc.ru).

## Requirements

The software has been developed in [Debian
GNU/Linux](http://debian.org), specifically Debian 11 (bullseye), and
is known to work in Debian 12 (bookworm) too.  It should be portable
to any platform where
[ESP-IDF](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/get-started/index.html)
runs.

You need some LogicBox hardware to exercise these tools; as a minimum,
one of LogicBox base modules (__LB241BC__, __LB241CPU__, or
__LB340CPU__) in the same Ethernet LAN as your computer.

## Installation

1. Clone this repository along with dependencies:

   ```
   git clone https://github.com/it-npc/logicbox
   cd logicbox
   git submodule update --init --recursive
   ```
1. Say `make -C matiec` to build `matiec` translators (only necessary
   to control PLC, not needed for __LB241BC__ RTU module)

1. Read `quickstart.pdf`, run the examples as described there to get
   your hands on the thing.

