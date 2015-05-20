FROM ubuntu:14.04
MAINTAINER imos@docker.com

# Install SSH server.
RUN apt-get update -qq && \
    apt-get install -qqy openssh-server
RUN mkdir /var/run/sshd

# Install useful tools.
RUN apt-get update -qq && \
    apt-get install -qqy \
        build-essential devscripts ubuntu-standard software-properties-common \
        vim git subversion mercurial cmake make \
        dos2unix nkf curl xz-utils

# Install C++.
RUN apt-get update -qq && apt-get install -qqy clang-3.6 clang-format-3.6

# Install scripts (python, php, ruby).
RUN apt-get update -qq && \
    apt-get install -qqy \
        python3.4 ruby1.9.3 rubygems-integration php5-cli python-pip

# Install C#.
RUN apt-get update -qq && apt-get install -qqy mono-devel

# Install Haskell.
RUN apt-get update -qq && apt-get install -qqy haskell-platform && cabal update

# Install Go.
RUN apt-get update -qq && apt-get install -qqy golang

# Install Java.
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 \
        select true | debconf-set-selections && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update -qq && apt-get install -qqy oracle-java8-installer

# Install JavaScript.
# RUN wget -O - https://deb.nodesource.com/setup | bash && \
#     apt-get install -qqy nodejs npm

# Install AWS command.
RUN pip install awscli

# Add ninelet user.
RUN useradd \
        --home-dir=/home/ninelet \
        --create-home \
        --uid=20602 \
        --user-group \
        --shell=/bin/bash \
        ninelet
RUN mkdir -p /home/ninelet/.ssh
RUN echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCrHaL3kdZ2RekCdpkie3fsiv2yVyyWRBOO6Q68Kr+tFStRqtF8q1/UoeteUIOxzwKaAmHoaM9PkItdMBki0BLQDimCZwjjbkosritGDMTJXGd21O72mWaTv+nfq+/ishCdt6gdBYXTejvpPJhq8ZMYhTYJZkWqlGO2CKrWcnHHu1HhnValeqNWS5nh8BULOTMKaixjdzXIkWgm8HyiewvqjZXC3tZlfFDErRpiS7SYfJHd4PujjFCNyiVxZ5yOvEGMXQa1UFxQlfX8H+lAr6qObK50osAdUbvjjbhIhMvZT2higSNNtv/yiaLRnLbbOHomObvqxob5TUVdCkazXX3N imos@docker' > /home/ninelet/.ssh/authorized_keys
RUN echo 'ninelet ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers.d/ninelet

# Set language settings.
RUN echo 'LANGUAGE=en_US.UTF8' >> /etc/environment
RUN echo 'LANG=en_US.UTF8' >> /etc/environment
RUN echo 'LC_ALL=en_US.UTF8' >> /etc/environment

# Set a ninecluster role.
RUN echo 'NINECLUSTER=ninelet' >> /etc/environment

# Set up imos/bin.
RUN grep '/usr/local/imos/bin:' /etc/environment || \
    sed -i 's%PATH="%PATH="/usr/local/imos/bin:%' /etc/environment
RUN mkdir -p /usr/local/imos/bin
RUN git clone 'https://github.com/imos/bin' /usr/local/imos/bin

EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd", "-D", "-o", "ClientAliveInterval 5", "-o", "ClientAliveCountMax 3"]
