FROM ubuntu:14.04
MAINTAINER imos@docker.com

RUN apt-get update -qq && \
    apt-get install -qqy openssh-server
RUN mkdir /var/run/sshd

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

EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd", "-D", "-o", "ClientAliveInterval 5", "-o", "ClientAliveCountMax 3"]
