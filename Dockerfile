FROM ubuntu:latest

ARG USER="ubuntu"
ARG PASSWORD="Test1234"

RUN apt update

RUN apt install \
    openssh-server \
    sudo -y

#Enable root user
RUN  echo 'root:password' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 $USER 

RUN usermod -aG sudo $USER

RUN service ssh start

RUN echo "$USER:$PASSWORD" | chpasswd

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
