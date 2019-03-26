#use latest armv7hf compatible raspbian OS version from group resin.io as base image
FROM balenalib/armv7hf-debian:stretch

#enable building ARM container on x86 machinery on the web (comment out next line if built on Raspberry) 
RUN [ "cross-build-start" ]

#install ssh, give user "root" a password
RUN apt-get update  \
    && apt-get install -y openssh-server \
    && echo 'root:root' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
    && mkdir /var/run/sshd \

#install python
RUN apt-get install -y build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev liblapack-dev libblas-dev  wget  git  cmake  \
    && wget https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tar.xz \
    && tar xf Python-3.7.2.tar.xz \
    && cd /root/Python-3.7.2
    && ./configure \
    && make -j "$(nproc)" \
    && make altinstall \

#SSH port
EXPOSE 22

#start SSH as service
ENTRYPOINT ["/usr/sbin/sshd", "-D"]

#set STOPSGINAL
STOPSIGNAL SIGTERM

#stop processing ARM emulation (comment out next line if built on Raspberry)
RUN [ "cross-build-end" ]
