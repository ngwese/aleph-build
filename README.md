aleph-build
===========

A docker image containing the toolchain required for [aleph](https://github.com/monome/aleph) development.

After cloning the repository manually download the avr32 toolchain and headers [from Atmel](http://www.atmel.com/tools/ATMELAVRTOOLCHAINFORLINUX.aspx) (Atmel requires registration in order to gain access the free development tools). Locate and download:
* "Atmel AVR 32-bit Toolchain 3.4.2 - Linux 64-bit"
* "Atmel AVR 8-bit and 32-bit Toolchain (3.4.2) 6.1.3.1475 - Header Files"

...the files are named avr32-gnu-toolchain-3.4.2.435-linux.any.x86_64.tar.gz and atmel-headers-6.1.3.1475.zip respectively. Place the downloaded files in a directly called ```dist``` next to the ```Dockerfile```

By default the image will start ```bash``` in a directory called ```/aleph``` - mapping ones source tree (called _"release"_ here) into the container can be done like so:

```
docker run -it -v $(pwd)/release:/aleph aleph-build
```

