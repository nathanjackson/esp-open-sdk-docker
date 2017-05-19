FROM ubuntu:14.04
MAINTAINER Nathan Jackson <nate.ds.jackson@gmail.com>

# Pre-reqs
RUN apt-get update; \
    apt-get install -y make unrar-free autoconf automake libtool gcc g++ gperf \
    flex bison texinfo gawk ncurses-dev libexpat-dev python-dev python \
    python-serial sed git unzip bash help2man wget bzip2; \
    rm -rf /var/lib/apt/lists/*; \
    useradd -ms /bin/bash esp8266

# Toolchain build must run as a non-root user.
USER esp8266
WORKDIR /home/esp8266

# Build and add the toolchain to the PATH.
RUN git clone --recursive https://github.com/pfalcon/esp-open-sdk.git; \
    cd esp-open-sdk; \
    make; \
    echo "export PATH=/home/esp8266/esp-open-sdk/xtensa-lx106-elf/bin:$PATH" | tee -a /home/esp8266/.bashrc
