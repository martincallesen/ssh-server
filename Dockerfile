FROM ubuntu:latest

ARG USER="test"
ARG PASSWORD="test"

RUN apt update

RUN apt install openssh-server sudo -y

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 $USER 

RUN usermod -aG sudo $USER

RUN service ssh start

RUN echo "$USER:$PASSWORD" | chpasswd

# Disable root user login
RUN echo 'PermitRootLogin no' >> /etc/ssh/ssh_config
RUN echo 'ChallengeResponseAuthentication no' >> /etc/ssh/ssh_config
RUN echo 'PasswordAuthentication no' >> /etc/ssh/ssh_config
RUN echo 'UsePAM no' >> /etc/ssh/ssh_config

# Disable Empty Passwords
RUN echo 'PermitEmptyPasswords no' >> /etc/ssh/ssh_config

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
