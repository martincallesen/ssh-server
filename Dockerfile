FROM ubuntu:latest

ARG USER="ubuntu"
ARG PASSWORD="Test1234"

RUN apt update

RUN apt install openssh-server sudo -y

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 $USER 

RUN usermod -aG sudo $USER

RUN service ssh start

RUN echo "$USER:$PASSWORD" | chpasswd

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
