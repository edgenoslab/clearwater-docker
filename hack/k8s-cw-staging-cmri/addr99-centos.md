Table of contents
==================

* Adjust LVM


Adjust lVM
------------

Staging的FileSystem目标是满足验证

* root卷需要足够的空间，以可分配给kubelet和docker, etcd

  `/var/lib/kubelet`

  `/var/lib/docker`

  `/var/lib/etcd`

* 在production中，上述FS将使用单独的High Performance Stroage  

初始的FS

    [root@centos7 ~]# vgs
      VG      #PV #LV #SN Attr   VSize   VFree
      vg_data   1   3   0 wz--n- 557.37g 60.00m

    [root@centos7 ~]# lvs
      LV      VG      Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
      lv_home vg_data -wi-ao---- 492.41g                                                    
      lv_root vg_data -wi-ao----  50.00g                                                    
      lv_swap vg_data -wi-ao----  14.91g           

调整后的FS

    [root@centos7 ~]# lvreduce --size=-400g vg_data/lv_home
      WARNING: Reducing active and open logical volume to 92.41 GiB
      THIS MAY DESTROY YOUR DATA (filesystem etc.)
    Do you really want to reduce lv_home? [y/n]: y
      Size of logical volume vg_data/lv_home changed from 492.41 GiB (126056 extents) to 92.41 GiB (23656 extents).
      Logical volume lv_home successfully resized

    [root@centos7 ~]# lvs
      LV      VG      Attr       LSize  Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
      lv_home vg_data -wi-ao---- 92.41g                                                    
      lv_root vg_data -wi-ao---- 50.00g                                                    
      lv_swap vg_data -wi-ao---- 14.91g             

    [root@centos7 ~]# lvextend --size=+100g vg_data/lv_root
      Size of logical volume vg_data/lv_root changed from 50.00 GiB (12800 extents) to 150.00 GiB (38400 extents).
      Logical volume lv_root successfully resized

    [root@centos7 ~]# lvs
      LV      VG      Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
      lv_home vg_data -wi-ao----  92.41g                                                    
      lv_root vg_data -wi-ao---- 150.00g                                                    
      lv_swap vg_data -wi-ao----  14.91g                                                    

在pool中的未分配storage

* vg_data中未分配：300G

* /dev/sdb，/dev/sdc


Update CentOS packages
-----------------------

系统摘要

    [root@centos7 ~]# cat /etc/redhat-release
    CentOS Linux release 7.1.1503 (Core)

    [root@centos7 ~]# uname -r
    3.10.0-229.el7.x86_64

Update

    [root@centos7 ~]# yum check-update

    [root@centos7 ~]# yum update

Physical Networking
--------------------

检查

    [root@centos7 ~]# ip a
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
        inet 127.0.0.1/8 scope host lo
           valid_lft forever preferred_lft forever
        inet6 ::1/128 scope host
           valid_lft forever preferred_lft forever
    2: enp17s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP qlen 1000
        link/ether 00:0a:f7:50:1f:70 brd ff:ff:ff:ff:ff:ff
    3: eno2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP qlen 1000
        link/ether 40:f2:e9:de:30:e2 brd ff:ff:ff:ff:ff:ff
        inet 192.168.39.99/24 brd 192.168.39.255 scope global dynamic eno2
           valid_lft 588sec preferred_lft 588sec
        inet6 fe80::42f2:e9ff:fede:30e2/64 scope link
           valid_lft forever preferred_lft forever
    4: enp17s0f1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN qlen 1000
        link/ether 00:0a:f7:50:1f:72 brd ff:ff:ff:ff:ff:ff
    5: eno3: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN qlen 1000
        link/ether 40:f2:e9:de:30:e3 brd ff:ff:ff:ff:ff:ff
    6: eno4: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN qlen 1000
        link/ether 40:f2:e9:de:30:e4 brd ff:ff:ff:ff:ff:ff
    7: eno5: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN qlen 1000
        link/ether 40:f2:e9:de:30:e5 brd ff:ff:ff:ff:ff:ff
    9: enp0s29u1u1u5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
        link/ether 42:f2:e9:de:30:e1 brd ff:ff:ff:ff:ff:ff
        inet 169.254.95.120/24 brd 169.254.95.255 scope link dynamic enp0s29u1u1u5
           valid_lft 461sec preferred_lft 461sec
        inet6 fe80::40f2:e9ff:fede:30e1/64 scope link
           valid_lft forever preferred_lft forever

    [root@centos7 ~]# systemctl is-active  NetworkManager.service
    active

    [root@centos7 ~]# nmcli d
    警告：nmcli (1.0.6) 和 NetworkManager (1.0.0) 版本不匹配。请使用 --nocheck 抑制警告。
    设备           类型      状态    CONNECTION    
    eno2           ethernet  连接的  eno2          
    enp0s29u1u1u5  ethernet  连接的  enp0s29u1u1u5
    enp17s0f0      ethernet  已断开  --            
    eno3           ethernet  不可用  --            
    eno4           ethernet  不可用  --            
    eno5           ethernet  不可用  --            
    enp17s0f1      ethernet  不可用  --            
    lo             loopback  未管理  --            

    [root@centos7 ~]# nmcli c
    警告：nmcli (1.0.6) 和 NetworkManager (1.0.0) 版本不匹配。请使用 --nocheck 抑制警告。
    名称                UUID                                  类型            设备          
    enp0s29u1u1u5       e6d1136b-2c31-4690-a147-98cb2d9290b9  802-3-ethernet  enp0s29u1u1u5
    eno2                2f96bfde-c41a-47bc-bd50-e5e32ca55ab7  802-3-ethernet  eno2          
    eno3                7dc754bc-e237-47f4-89b3-19767fedd636  802-3-ethernet  --            
    Wired connection 1  06a7ad6b-32d9-4346-9370-ba28d5452426  802-3-ethernet  enp17s0f0     
    eno5                0bbbc041-6935-4006-85bd-a71a1fd20e3c  802-3-ethernet  --            
    enp17s0f1           a0d554e7-da72-47c3-a2c5-3578046376b0  802-3-ethernet  --            
    eno4                cd887cee-a45a-41a4-88e5-ac897ebfc945  802-3-ethernet  --            

    [root@centos7 ~]# systemctl  disable  firewalld.service


安装docker, etcd, flannel
-----------------------------

Install `docker` packages

    [root@centos7 ~]# yum install -y docker
    已加载插件：fastestmirror, langpacks
    Loading mirror speeds from cached hostfile
     * base: mirrors.aliyun.com
     * extras: mirrors.aliyun.com
     * updates: mirrors.aliyun.com


    ====================================================================================================
     Package                       架构          版本                               源             大小
    ====================================================================================================
    正在安装:
     docker                        x86_64        1.10.3-46.el7.centos.14            extras        9.5 M
    为依赖而安装:
     audit-libs-python             x86_64        2.4.1-5.el7                        base           69 k
     checkpolicy                   x86_64        2.1.12-6.el7                       base          247 k
     docker-common                 x86_64        1.10.3-46.el7.centos.14            extras         61 k
     docker-selinux                x86_64        1.10.3-46.el7.centos.14            extras         79 k
     libcgroup                     x86_64        0.41-8.el7                         base           64 k
     libseccomp                    x86_64        2.2.1-1.el7                        base           49 k
     libsemanage-python            x86_64        2.1.10-18.el7                      base           94 k
     oci-register-machine          x86_64        1:0-1.8.gitaf6c129.el7             extras        1.1 M
     oci-systemd-hook              x86_64        1:0.1.4-4.git41491a3.el7           extras         27 k
     policycoreutils-python        x86_64        2.2.5-20.el7                       base          435 k
     python-IPy                    noarch        0.75-6.el7                         base           32 k
     setools-libs                  x86_64        3.3.7-46.el7                       base          485 k

    事务概要
    ====================================================================================================
    安装  1 软件包 (+12 依赖软件包)

Install `etcd` and `flannel` packages

    [root@centos7 ~]# yum install -y etcd flannel
    已加载插件：fastestmirror, langpacks
    Loading mirror speeds from cached hostfile
     * base: mirrors.aliyun.com
     * extras: mirrors.aliyun.com
     * updates: mirrors.aliyun.com
    正在解决依赖关系
    --> 正在检查事务
    ---> 软件包 etcd.x86_64.0.2.3.7-4.el7 将被 安装
    ---> 软件包 flannel.x86_64.0.0.5.3-9.el7 将被 安装
    --> 解决依赖关系完成

    依赖关系解决

    ====================================================================================================
     Package               架构                 版本                         源                    大小
    ====================================================================================================
    正在安装:
     etcd                  x86_64               2.3.7-4.el7                  extras               6.5 M
     flannel               x86_64               0.5.3-9.el7                  extras               1.7 M

    事务概要
    ====================================================================================================
    安装  2 软件包


    [root@centos7 ~]# sudo systemctl list-unit-files docker.service etcd.service flanneld.service
    UNIT FILE        STATE   
    docker.service   disabled
    etcd.service     disabled
    flanneld.service disabled

    3 unit files listed.

安装kubernetes
---------------

Download `kubernetes` packages

    fanhonglingdeMacBook-Pro:trusty64 fanhongling$ scp -r /Volumes/TOURO\ Mobile/kubernetes/{kube,kubernetes,kubernetes.tar.gz} root@192.168.39.99:/root
