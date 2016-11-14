About
=======

有关详细的操作，见`addr99-***`前缀的文件

Adjust FileSystem
-------------------

    [root@centos7 ~]# vgs
      VG      #PV #LV #SN Attr   VSize   VFree
      vg_data   1   3   0 wz--n- 557.37g 60.00m

    [root@centos7 ~]# lvs
      LV      VG      Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
      lv_home vg_data -wi-ao---- 492.41g
      lv_root vg_data -wi-ao----  50.00g
      lv_swap vg_data -wi-ao----  14.91g

    [root@centos7 ~]# mount | grep lv_home
    /dev/mapper/vg_data-lv_home on /home type ext4 (rw,relatime,seclabel,data=ordered)

    [root@centos7 ~]# lvreduce --size=92.41g vg_data/lv_home
      Rounding size to boundary between physical extents: 92.41 GiB
      WARNING: Reducing active and open logical volume to 92.41 GiB
      THIS MAY DESTROY YOUR DATA (filesystem etc.)
    Do you really want to reduce lv_home? [y/n]: y
      Size of logical volume vg_data/lv_home changed from 400.00 GiB (102400 extents) to 92.41 GiB (23657 extents).
      Logical volume lv_home successfully resized

    [root@centos7 ~]# lvextend --size=150g vg_data/lv_root
      Size of logical volume vg_data/lv_root changed from 50.00 GiB (12800 extents) to 150.00 GiB (38400 extents).
      Logical volume lv_root successfully resized

    [root@centos7 ~]# lvs
      LV      VG      Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
      lv_home vg_data -wi-ao----  92.41g
      lv_root vg_data -wi-ao---- 150.00g
      lv_swap vg_data -wi-ao----  14.91g

Update CentOS packages
-------------------------

OS

    [root@centos7 ~]# uname -r
    3.10.0-229.el7.x86_64

Update

    [root@centos7 ~]# yum check-update
    已加载插件：fastestmirror, langpacks
    Loading mirror speeds from cached hostfile
     * base: mirrors.btte.net
     * extras: ftp.sjtu.edu.cn
     * updates: ftp.sjtu.edu.cn

    [root@centos7 ~]# yum update
    已加载插件：fastestmirror, langpacks
    Loading mirror speeds from cached hostfile
     * base: mirrors.aliyun.com
     * extras: mirrors.aliyun.com
     * updates: mirrors.aliyun.com

物理网络
--------

Show

    [root@centos7 ~]# ip a show
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
        inet 127.0.0.1/8 scope host lo
           valid_lft forever preferred_lft forever
        inet6 ::1/128 scope host
           valid_lft forever preferred_lft forever
    2: enp17s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP qlen 1000
        link/ether 00:0a:f7:50:1a:f0 brd ff:ff:ff:ff:ff:ff
    3: eno2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP qlen 1000
        link/ether 40:f2:e9:de:c2:f2 brd ff:ff:ff:ff:ff:ff
        inet 192.168.39.100/24 brd 192.168.39.255 scope global dynamic eno2
           valid_lft 336sec preferred_lft 336sec
        inet6 fe80::42f2:e9ff:fede:c2f2/64 scope link
           valid_lft forever preferred_lft forever
    4: enp17s0f1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP qlen 1000
        link/ether 00:0a:f7:50:1a:f2 brd ff:ff:ff:ff:ff:ff
    5: eno3: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN qlen 1000
        link/ether 40:f2:e9:de:c2:f3 brd ff:ff:ff:ff:ff:ff
    6: eno4: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN qlen 1000
        link/ether 40:f2:e9:de:c2:f4 brd ff:ff:ff:ff:ff:ff
    7: eno5: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN qlen 1000
        link/ether 40:f2:e9:de:c2:f5 brd ff:ff:ff:ff:ff:ff
    8: enp0s29u1u1u5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UNKNOWN qlen 1000
        link/ether 42:f2:e9:de:c2:f1 brd ff:ff:ff:ff:ff:ff
        inet 169.254.95.120/24 brd 169.254.95.255 scope link dynamic enp0s29u1u1u5
           valid_lft 591sec preferred_lft 591sec
        inet6 fe80::40f2:e9ff:fede:c2f1/64 scope link
           valid_lft forever preferred_lft forever


工具
------

Such as `wget`, `netstat`, `git`

    [root@centos7 ~]# wget
    wget：未指定 URL
    用法： wget [选项]... [URL]...

    请尝试使用“wget --help”查看更多的选项。

    [root@centos7 ~]# netstat -tpnl
    Active Internet connections (only servers)
    Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
    tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN      21235/rpcbind       
    tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      31868/sshd          
    tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN      2701/master         
    tcp6       0      0 :::111                  :::*                    LISTEN      21235/rpcbind       
    tcp6       0      0 :::22                   :::*                    LISTEN      31868/sshd          
    tcp6       0      0 ::1:25                  :::*                    LISTEN      2701/master         

    [root@centos7 ~]# yum install -y git

安装docker, etcd, flannel
--------------------------

Install from `YUM`

    [root@centos7 ~]# yum install -y docker etcd flannel
    已加载插件：fastestmirror, langpacks
    Loading mirror speeds from cached hostfile
     * base: mirrors.btte.net
     * extras: ftp.sjtu.edu.cn
     * updates: ftp.sjtu.edu.cn


    ====================================================================================================
     Package                       架构          版本                               源             大小
    ====================================================================================================
    正在安装:
     docker                        x86_64        1.10.3-46.el7.centos.14            extras        9.5 M
     etcd                          x86_64        2.3.7-4.el7                        extras        6.5 M
     flannel                       x86_64        0.5.3-9.el7                        extras        1.7 M
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
    安装  3 软件包 (+12 依赖软件包)

安装kubernetes
---------------

Download `kubernetes` packages

    [root@centos7 ~]# wget -c https://github.com/kubernetes/kubernetes/releases/download/v1.3.10/kubernetes.tar.gz -b

    [root@centos7 ~]# tail wget-log
    1219850K .......... .......... .......... .......... .......... 83% 39.6K 7m20s
    1219900K .......... .......... .......... .......... .......... 83% 43.1K 7m20s
    1219950K .......... .......... .......... .......... .......... 83% 53.1K 7m20s
    1220000K .......... .......... .......... .......... .......... 83% 46.3K 7m20s
    1220050K .......... .......... .......... .......... .......... 83% 39.4K 7m21s
    1220100K .......... .......... .......... .......... .......... 83% 39.1K 7m21s
    1220150K .......... .......... .......... .......... .......... 83% 38.9K 7m21s
    1220200K .......... .......... .......... .......... .......... 83% 40.4K 7m21s
    1220250K .......... .......... .......... .......... .......... 83% 53.1K 7m21s
    1220300K .......... .......... ........

    [root@centos7 ~]# ls
    anaconda-ks.cfg  kubernetes.tar.gz  wget-log

DevOps relations

    [root@centos7 ~]# scp -r root@192.168.39.99:/root/{kube,kubernetes} .
