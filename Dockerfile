FROM ubuntu:18.04
RUN apt-get -y update
RUN apt-get -y install openssh-server
RUN apt-get -y install python3
RUN ln /usr/bin/python3 /usr/bin/python

RUN echo 'root:ubuntu' | chpasswd

RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config 
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config 

RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd
RUN echo 'export NOTVISIBLE="in users profile"' >> ~/.bashrc

RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
COPY ./authorized_keys /root/.ssh/authorized_keys

#sshd needs this directory to start 
RUN mkdir /run/sshd
#run sshd IPv4, without detaching on port 22 see: https://man.openbsd.org/sshd
CMD ["/usr/sbin/sshd", "-D", "-p", "22"]
