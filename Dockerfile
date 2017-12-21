FROM ubuntu

LABEL maintainer="Greg Wuller <greg@afofo.com>"

RUN apt-get update -y
RUN apt-get install -y \
    make \
    git \
    wget \
    unzip \
    bzip2 \
    alien \
    libjansson4

RUN mkdir -pv /dist
WORKDIR /dist

# install jansson
COPY dist/libjansson.tar.gz /dist
RUN alien -i /dist/libjansson.tar.gz

# unpack avr32 toolchain 
COPY dist/avr32-gnu-*.tar.gz /dist
RUN tar xvzf avr32-gnu-toolchain-*.tar.gz \
    && mv avr32-gnu-toolchain-linux_x86_64 avr32-gnu

# unpack headers into toolchain
COPY dist/atmel-headers-*.zip /dist
RUN unzip atmel-headers-*.zip \
    && mv -v atmel-headers-*/avr avr32-gnu/avr32/include/ \
    && mv -v atmel-headers-*/avr32 avr32-gnu/avr32/include/
    
# install avr32 toolchain
RUN mv -v avr32-gnu /opt/

# install blackfin toolchain
RUN wget http://downloads.sourceforge.net/project/adi-toolchain/2013R1/2013R1-RC1/x86_64/blackfin-toolchain-elf-gcc-4.3-2013R1-RC1.x86_64.tar.bz2
RUN tar xjvf blackfin-toolchain-elf-gcc-4.3-2013R1-RC1.x86_64.tar.bz2 \
    && mv -v opt/uClinux/bfin-elf /opt/

RUN rm -rf /dist

COPY extend-path.sh /etc/profile.d/
RUN cat /etc/profile.d/extend-path.sh >> /root/.bashrc

VOLUME /aleph
WORKDIR /aleph

CMD ["/bin/bash"]