FROM phusion/baseimage:0.9.18

# use baseimage-docker's init system
CMD ["/sbin/init"]

MAINTAINER Francis Kayiwa <kayiwa@pobox.com>

# ADD Anaconda source
ADD files/ /tmp

# update packages and install
RUN export DEBIAN_FRONTEND=noninteractive && \
        apt-get update && \
        apt-get upgrade -y && \
        apt-get install -y git \
                wget \
                bzip2 \
                build-essential \
                python-dev \
                gfortran

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create conda user
RUN useradd --create-home --home-dir /home/condauser --shell /bin/bash condauser
RUN /tmp/get_anaconda.sh
