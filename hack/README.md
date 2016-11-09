About
======

Tables of Content
-----------------

* Background

* POC

* Staging

Background
-----------

The R&D target is to depolying Metaswitch IMS into Kubernetes（v1.3+）

Cluster：

* 3 nodes CentOS 7.2 in Private Data center

* physical networking：

Project：

* inspired by Metaswitch clearwater-docker repository

从github克隆fork仓库

    tangf@DESKTOP-H68OQDV /cygdrive/g/work/src/github.com
    $ git clone https://github.com/stackdocker/clearwater-docker Metaswitch/clearwater-docker
    正克隆到 'Metaswitch/clearwater-docker'...
    remote: Counting objects: 431, done.
    remote: Total 431 (delta 0), reused 0 (delta 0), pack-reused 431
    接收对象中: 100% (431/431), 114.77 KiB | 57.00 KiB/s, 完成.
    处理 delta 中: 100% (204/204), 完成.
    检查连接... 完成。

    tangf@DESKTOP-H68OQDV /cygdrive/g/work/src/github.com
    $ cd Metaswitch/clearwater-docker/

    tangf@DESKTOP-H68OQDV /cygdrive/g/work/src/github.com/Metaswitch/clearwater-docker
    $ git remote -v
    origin  https://github.com/stackdocker/clearwater-docker (fetch)
    origin  https://github.com/stackdocker/clearwater-docker (push)

如果join community，以pull request

    tangf@DESKTOP-H68OQDV /cygdrive/g/work/src/github.com/Metaswitch/clearwater-docker
    $ git remote add upstream https://github.com/Metaswitch/clearwater-docker

    tangf@DESKTOP-H68OQDV /cygdrive/g/work/src/github.com/Metaswitch/clearwater-docker
    $ git remote -v
    origin  https://github.com/stackdocker/clearwater-docker (fetch)
    origin  https://github.com/stackdocker/clearwater-docker (push)
    upstream        https://github.com/Metaswitch/clearwater-docker (fetch)
    upstream        https://github.com/Metaswitch/clearwater-docker (push)

POC
-----
POC是开发者在Staging环境内无法或受限下（例如internet操作等），而在Staging环境外（如个人开发计算机，其它云端）按Staging相同架构而组建的开发环境：cluster的操作系统是一致的，cluster网络的结构是一致的。

### 使用virtualbox和vagrant平台

Reference:

* [virtualbox 5.0.28](https://www.virtualbox.org/wiki/Download_Old_Builds_5_0)

* [vagrant 1.8.6](https://releases.hashicorp.com/vagrant/1.8.6/)

* [centos7.2.1609 box](https://atlas.hashicorp.com/centos/boxes/7/versions/1609.01)

注：以上开发工具的版本，是基于当前的实践，如果在后续版本上也实践证明了的，可merge到该README中

Getting started：

    tangf@DESKTOP-H68OQDV /cygdrive/g/atlas.hashicorp.com/centos/boxes/7
    $ vagrant init --box-version=v1609.01 centos/7
    A `Vagrantfile` has been placed in this directory. You are now
    ready to `vagrant up` your first virtual environment! Please read
    the comments in the Vagrantfile as well as documentation on
    `vagrantup.com` for more information on using Vagrant.

编辑Vagrantfile文件，包括CentOS box版本，hostonly-network，shared-fs，memory

    tangf@DESKTOP-H68OQDV /cygdrive/g/atlas.hashicorp.com/centos/boxes/7
    $ vim Vagrantfile

        config.vm.box = "centos/7"
        config.vm.box_version = "1609.01"

        # config.vm.network "private_network", ip: "192.168.33.10"
        config.vm.network "private_network", ip: "10.64.33.81"

        # config.vm.synced_folder "../data", "/vagrant_data"
        config.vm.synced_folder "G:/work", "/work"

        # View the documentation for the provider you are using for more
        # information on available options.
        config.vm.provider "virtualbox" do |vb|
          vb.memory = 3072
        end

Provision VM

    tangf@DESKTOP-H68OQDV /cygdrive/g/atlas.hashicorp.com/centos/boxes/7
    $ vagrant up --provider virtualbox
    Bringing machine 'default' up with 'virtualbox' provider...
    ==> default: Box 'centos/7' could not be found. Attempting to find and install...
        default: Box Provider: virtualbox
        default: Box Version: 1609.01
    ==> default: Loading metadata for box 'centos/7'
        default: URL: https://atlas.hashicorp.com/centos/7
    ==> default: Adding box 'centos/7' (v1609.01) for provider: virtualbox
        default: Downloading: https://atlas.hashicorp.com/centos/boxes/7/versions/1609.01/providers/virtualbox.box
    ==> default: Box download is resuming from prior download progress
        default: Progress: 22% (Rate: 918k/s, Estimated time remaining: 0:04:57)

    tangf@DESKTOP-H68OQDV /cygdrive/g/atlas.hashicorp.com/centos/boxes/7
    $ vagrant ssh
    Last login: Mon Nov  7 11:36:53 2016 from 10.0.2.2
    [vagrant@localhost ~]$ ip a
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
        inet 127.0.0.1/8 scope host lo
           valid_lft forever preferred_lft forever
        inet6 ::1/128 scope host
           valid_lft forever preferred_lft forever
    2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
        link/ether 52:54:00:9f:bd:fd brd ff:ff:ff:ff:ff:ff
        inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic eth0
           valid_lft 86081sec preferred_lft 86081sec
        inet6 fe80::5054:ff:fe9f:bdfd/64 scope link
           valid_lft forever preferred_lft forever
    3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
        link/ether 08:00:27:c7:35:fe brd ff:ff:ff:ff:ff:ff
        inet 10.64.33.81/24 brd 10.64.33.255 scope global eth1
           valid_lft forever preferred_lft forever
        inet6 fe80::a00:27ff:fec7:35fe/64 scope link
           valid_lft forever preferred_lft forever

     [vagrant@localhost ~]$ cat /etc/redhat-release
     CentOS Linux release 7.2.1511 (Core)

     [vagrant@localhost ~]$ uname -r
     3.10.0-327.36.1.el7.x86_64

     [vagrant@localhost ~]$ sudo df -h
     Filesystem                       Size  Used Avail Use% Mounted on
     /dev/mapper/VolGroup00-LogVol00   38G  884M   37G   3% /
     devtmpfs                         1.4G     0  1.4G   0% /dev
     tmpfs                            1.4G     0  1.4G   0% /dev/shm
     tmpfs                            1.4G  8.3M  1.4G   1% /run
     tmpfs                            1.4G     0  1.4G   0% /sys/fs/cgroup
     /dev/sda2                        497M  126M  372M  26% /boot
     tmpfs                            285M     0  285M   0% /run/user/1000

     [vagrant@localhost ~]$ ls /dev/sd*
     /dev/sda  /dev/sda1  /dev/sda2  /dev/sda3

     [vagrant@localhost ~]$ sudo pvdisplay
       --- Physical volume ---
       PV Name               /dev/sda3
       VG Name               VolGroup00
       PV Size               39.51 GiB / not usable 10.00 MiB
       Allocatable           yes
       PE Size               32.00 MiB
       Total PE              1264
       Free PE               10
       Allocated PE          1254
       PV UUID               oUVt67-9kA8-uxSc-e6rl-J6ER-unza-Yuc0IA


### More documentations

In *kubernetes-clearwater* path. now including:

* Docker v1.10.3 installation

* Kubernetes v1.4 installation

Staging
---------

Documentations are archived in *k8s-cw-staging-cmri* path

Currently including:

* Install k8s v1.4 cluster into staging cluster
