About
======

Here is working around CentOS development tools, such as *gcc, make,* and so on

ISO media
-------------

Using packages from ISO media

```Linux Shell

[vagrant@localhost ~]$ cat /etc/yum.repos.d/CentOS-Media.repo
# CentOS-Media.repo
#
#  This repo can be used with mounted DVD media, verify the mount point for
#  CentOS-7.  You can use this repo and yum to install items directly off the
#  DVD ISO that we release.
#
# To use this repo, put in your DVD and use it with the other repos too:
#  yum --enablerepo=c7-media [command]
#
# or for ONLY the media repo, do this:
#
#  yum --disablerepo=\* --enablerepo=c7-media [command]

[c7-media]
name=CentOS-$releasever - Media
baseurl=file:///media/CentOS/
        file:///media/cdrom/
        file:///media/cdrecorder/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

[vagrant@localhost ~]$ sudo mkdir -p /media/CentOS

[vagrant@localhost ~]$ sudo mount -t iso9660 -o loop /vagrant/CentOS-7-x86_64-Everything-1511.iso /media/CentOS
mount: /dev/loop2 is write-protected, mounting read-only

[vagrant@localhost ~]$ ls /media/CentOS/
CentOS_BuildTag  GPL       LiveOS    RPM-GPG-KEY-CentOS-7
EFI              images    Packages  RPM-GPG-KEY-CentOS-Testing-7
EULA             isolinux  repodata  TRANS.TBL

[vagrant@localhost ~]$ sudo yum --disablerepo=\* --enablerepo=c7-media repolist
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * c7-media:
c7-media/primary_db                                        | 2.8 MB   00:00
repo id                          repo name                                status
c7-media                         CentOS-7 - Media                         0
repolist: 0

```

* Install net-tools

```
[vagrant@localhost ~]$ sudo yum list net-tools
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirrors.zju.edu.cn
 * extras: mirrors.zju.edu.cn
 * updates: mirrors.zju.edu.cn
Available Packages
net-tools.x86_64                  2.0-0.17.20131004git.el7                  base


```
