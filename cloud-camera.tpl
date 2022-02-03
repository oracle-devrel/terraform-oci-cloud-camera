#cloud-config
# Copyright (c) 2022 Oracle and/or its affiliates.

runcmd:
  - dnf update -y
  - dnf groupinstall -y "Server with GUI"
  - dnf install -y tigervnc-server
  - systemctl set-default graphical.target
  - ln -sf /lib/systemd/system/runlevel5.target /etc/systemd/system/default.target
  # credit to: https://stackoverflow.com/questions/2854655/command-to-escape-a-string-in-bash for this...
  - sh -c "printf \"%s\n%s\n\n\" `printf \"%q\" '${opc_passwd}'` `printf \"%q\" '${opc_passwd}'` | passwd opc"
  - chown opc:opc -R /home/opc
  - sudo -u opc sh -c "printf \"%s\n%s\n\n\" `printf \"%q\" '${vnc_passwd}'` `printf \"%q\" '${vnc_passwd}'` | vncpasswd"
  - sh -c "echo \":1=opc\" >> /etc/tigervnc/vncserver.users"
  - setenforce 0
  - sed -u -E 's#SELINUX=enforcing#SELINUX=permissive#i' /etc/selinux/config 2>&1 > /etc/selinux/config2 && mv -f /etc/selinux/config2 /etc/selinux/config
  - systemctl enable vncserver@:1
  - systemctl start vncserver@:1
  - systemctl stop firewalld
  - systemctl disable firewalld
  - dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
  - dnf install -y https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm
  - dnf install -y vlc
