About
======

Here is working around CentOS development tools, such as *gcc, make,* and so on

ISO media
-------------

Using packages from ISO media

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

* Tools

For *net-tools*

    [vagrant@localhost ~]$ sudo yum list net-tools
    Loaded plugins: fastestmirror
    Loading mirror speeds from cached hostfile
     * base: mirrors.zju.edu.cn
     * extras: mirrors.zju.edu.cn
     * updates: mirrors.zju.edu.cn
    Available Packages
    net-tools.x86_64                  2.0-0.17.20131004git.el7                  base

    [vagrant@localhost ~]$ sudo mount /dev/sr0 /media/CentOS
    mount: /dev/sr0 is write-protected, mounting read-only

    [vagrant@localhost ~]$ sudo yum --disablerepo=\* --enablerepo=c7-media install net-tools
    Loaded plugins: fastestmirror
    c7-media                                                 | 3.6 kB     00:00
    Not using downloaded repomd.xml because it is older than what we have:
      Current   : Wed Dec  9 23:14:09 2015
      Downloaded: Wed Dec  9 22:35:45 2015
    Loading mirror speeds from cached hostfile
     * c7-media:
    Resolving Dependencies
    --> Running transaction check
    ---> Package net-tools.x86_64 0:2.0-0.17.20131004git.el7 will be installed
    --> Finished Dependency Resolution

    Dependencies Resolved

    ================================================================================
     Package        Arch        Version                         Repository     Size
    ================================================================================
    Installing:
     net-tools      x86_64      2.0-0.17.20131004git.el7        c7-media      304 k

    Transaction Summary
    ================================================================================
    Install  1 Package

    [vagrant@localhost ~]$ sudo netstat -tpnl
    Active Internet connections (only servers)
    Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
    tcp        0      0 127.0.0.1:2380          0.0.0.0:*               LISTEN      998/etcd
    tcp        0      0 127.0.0.1:8080          0.0.0.0:*               LISTEN      1225/kube-apiserver
    tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      993/sshd
    tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN      1430/master
    tcp        0      0 127.0.0.1:7001          0.0.0.0:*               LISTEN      998/etcd
    tcp6       0      0 :::6443                 :::*                    LISTEN      1225/kube-apiserver
    tcp6       0      0 :::2379                 :::*                    LISTEN      998/etcd
    tcp6       0      0 :::22                   :::*                    LISTEN      993/sshd
    tcp6       0      0 ::1:25                  :::*                    LISTEN      1430/master

For *wget*

    [vagrant@localhost ~]$ sudo yum --disablerepo=\* --enablerepo=c7-media install wget
    Loaded plugins: fastestmirror
    Loading mirror speeds from cached hostfile
     * c7-media:
    Resolving Dependencies
    --> Running transaction check
    ---> Package wget.x86_64 0:1.14-10.el7_0.1 will be installed
    --> Finished Dependency Resolution

    Dependencies Resolved

    ================================================================================
     Package       Arch            Version                  Repository         Size
    ================================================================================
    Installing:
     wget          x86_64          1.14-10.el7_0.1          c7-media          545 k

    Transaction Summary
    ================================================================================
    Install  1 Package

    [vagrant@localhost ~]$ wget
    wget: missing URL
    Usage: wget [OPTION]... [URL]...

    Try `wget --help' for more options.

For __NTP__

	[tangfx@localhost k8s-manifests]$ sudo dnf install chrony
	Last metadata expiration check: 2:34:08 ago on Fri Dec  9 04:46:01 2016.
	Dependencies resolved.
	================================================================================
	 Package           Arch           Version                 Repository       Size
	================================================================================
	Installing:
	 chrony            x86_64         2.4.1-1.fc23            updates         225 k
	 timedatex         x86_64         0.3-3.fc23              fedora           30 k

	Transaction Summary
	================================================================================
	Install  2 Packages

	[tangfx@localhost k8s-manifests]$ sudo systemctl enable chronyd.service
	[tangfx@localhost k8s-manifests]$ sudo systemctl start chronyd.service
	[tangfx@localhost k8s-manifests]$ sudo timedatectl
		  Local time: Fri 2016-12-09 07:21:32 CST
	  Universal time: Thu 2016-12-08 23:21:32 UTC
			RTC time: Thu 2016-12-08 23:21:32
		   Time zone: Asia/Shanghai (CST, +0800)
	 Network time on: yes
	NTP synchronized: no
	 RTC in local TZ: no

	[tangfx@localhost k8s-manifests]$ sudo timedatectl set-timezone UTC

	[tangfx@localhost k8s-manifests]$ sudo chronyc -a makestep
	200 OK
		 
	[tangfx@localhost k8s-manifests]$ sudo timedatectl set-ntp yes	 

	[tangfx@localhost k8s-manifests]$ sudo date --set "2016-12-09 09:08:37" --utc   Fri Dec  9 09:08:37 UTC 2016
	[tangfx@localhost k8s-manifests]$ sudo hwclock --set --utc --date "`date`"
	[tangfx@localhost k8s-manifests]$ sudo timedatectl
		  Local time: Fri 2016-12-09 09:09:12 UTC
	  Universal time: Fri 2016-12-09 09:09:12 UTC
			RTC time: Fri 2016-12-09 09:09:12
		   Time zone: UTC (UTC, +0000)
	 Network time on: yes
	NTP synchronized: yes
	 RTC in local TZ: no
