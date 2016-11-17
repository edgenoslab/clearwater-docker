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

     [root@centos7 ~]# cat /etc/resolv.conf
     nameserver 8.8.8.8

关闭 firewall

    [root@centos7 ~]# systemctl stop firewalld.service

    [root@centos7 ~]# systemctl disable firewalld.service
    Removed symlink /etc/systemd/system/basic.target.wants/firewalld.service.
    Removed symlink /etc/systemd/system/dbus-org.fedoraproject.FirewallD1.service.

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

    [root@centos7 ~]# tar -C /opt -zxf kubernetes.tar.gz kubernetes/server/kubernetes-server-linux-amd64.tar.gz

    [root@centos7 ~]# tar -C /opt -zxf /opt/kubernetes/server/kubernetes-server-linux-amd64.tar.gz

    [root@centos7 ~]# ln -s /opt/kubernetes/server/bin/kubectl bin/

    [root@centos7 ~]# mkdir .kube

    [root@centos7 ~]# scp 192.168.39.99:/root/.kube/config .kube/
    root@192.168.39.99's password:
    config                                                              100%   10KB   9.9KB/s   00:00    

    [root@centos7 ~]# mkdir -p /opt/kubernetes/cacerts

    [root@centos7 ~]# mkdir -p /etc/kubernetes/cacerts

    [root@centos7 ~]# scp -r 192.168.39.99:/opt/kubernetes/cacerts /opt/kubernetes/
    root@192.168.39.99's password:
    ca.crt                                                              100% 1224     1.2KB/s   00:00    
    kubecfg.crt                                                         100% 4423     4.3KB/s   00:00    
    server.cert                                                         100% 4882     4.8KB/s   00:00    
    server.key                                                          100% 1708     1.7KB/s   00:00    
    kubecfg.key                                                         100% 1704     1.7KB/s   00:00    

    [root@centos7 ~]# cp -r /opt/kubernetes/cacerts/* /etc/kubernetes/cacerts/

    [root@centos7 ~]# scp 192.168.39.99:/etc/kubernetes/kubeconfig /etc/kubernetes/
    root@192.168.39.99's password:
    kubeconfig                                                          100%   10KB   9.9KB/s   00:00    

Deployment tool

    [root@centos7 ~]# scp -r root@192.168.39.99:/root/{kube,kubernetes} .

Setup `kubelet` service

    [root@centos7 ~]# scp -r 192.168.39.99:/root/kubernetes/1.3.10/centos/systemd kubernetes/1.3.10/centos/
    root@192.168.39.99's password:
    kube-apiserver.service                                              100%  640     0.6KB/s   00:00    
    kube-controller-manager.service                                     100%  676     0.7KB/s   00:00    
    kube-proxy.service                                                  100%  607     0.6KB/s   00:00    
    kubelet.service                                                     100%  748     0.7KB/s   00:00    
    kube-scheduler.service                                              100%  616     0.6KB/s   00:00    
    kube-scheduler                                                      100%  723     0.7KB/s   00:00    
    kubelet                                                             100% 1791     1.8KB/s   00:00    
    kube-controller-manager                                             100%  934     0.9KB/s   00:00    
    kube-apiserver                                                      100% 2211     2.2KB/s   00:00    
    kube-proxy                                                          100%  893     0.9KB/s   00:00

    [root@centos7 ~]# cp kubernetes/1.3.10/centos/systemd/system/kubelet.service /etc/systemd/system

    [root@centos7 ~]# vi kubernetes/1.3.10/centos/sysconfig/kubelet

    [root@centos7 ~]# cp kubernetes/1.3.10/centos/systemd/conf/kubelet /etc/sysconfig/

    [root@centos7 ~]# systemctl enable kubelet.service
    Created symlink from /etc/systemd/system/multi-user.target.wants/kubelet.service to /etc/systemd/system/kubelet.service.

    [root@centos7 ~]# systemctl start kubelet.service

    [root@centos7 ~]# systemctl -l status kubelet.service
    ● kubelet.service - Kubernetes container mgmt daemon - kubelet
       Loaded: loaded (/etc/systemd/system/kubelet.service; enabled; vendor preset: disabled)
       Active: active (running) since 三 2016-11-16 18:36:28 CST; 9s ago
         Docs: https://github.com/kubernetes/kubernetes
      Process: 20131 ExecStartPre=/usr/bin/mkdir -p /var/log/containers (code=exited, status=0/SUCCESS)
      Process: 20128 ExecStartPre=/usr/bin/mkdir -p /etc/kubernetes/manifests (code=exited, status=0/SUCCESS)
     Main PID: 20135 (kubelet)
       CGroup: /system.slice/kubelet.service
               ├─20135 /opt/kubernetes/server/bin/kubelet --address=192.168.39.100 --allow-privileged=true --api-servers=https://192.168.39.99:6443 --cadvisor-port=4194 --cert-dir=/opt/kubernetes/cacerts --cluster-dns=10.123.240.10 --cluster-domain=cluster.local --config=/etc/kubernetes/manifests --configure-cbr0=false --container-runtime=docker --docker=unix:///var/run/docker.sock --healthz-bind-address=127.0.0.1 --healthz-port=10248 --hostname-override=192.168.39.100 --kubeconfig=/etc/kubernetes/kubeconfig --master-service-namespace=default --max-open-files=1000000 --max-pods=0 --node-ip=192.168.39.100 --non-masquerade-cidr=10.0.0.0/8 --pod-infra-container-image=gcr.io/google_containers/pause-amd64:3.0 --pods-per-core=0 --port=10250 --read-only-port=10255 --root-dir=/var/lib/kubelet --tls-cert-file=/opt/kubernetes/cacerts/server.cert --tls-private-key-file=/opt/kubernetes/cacerts/server.key --v=2
               └─20222 journalctl -k -f

    11月 16 18:36:29 centos7 kubelet[20135]: E1116 18:36:29.371594   20135 manager.go:240] Registration of the rkt container factory failed: unable to communicate with Rkt api service: rkt: cannot tcp Dial rkt api service: dial tcp [::1]:15441: getsockopt: connection refused
    11月 16 18:36:29 centos7 kubelet[20135]: I1116 18:36:29.371605   20135 factory.go:54] Registering systemd factory
    11月 16 18:36:29 centos7 kubelet[20135]: I1116 18:36:29.372208   20135 factory.go:86] Registering Raw factory
    11月 16 18:36:29 centos7 kubelet[20135]: I1116 18:36:29.372819   20135 manager.go:1072] Started watching for new ooms in manager
    11月 16 18:36:29 centos7 kubelet[20135]: I1116 18:36:29.374199   20135 oomparser.go:185] oomparser using systemd
    11月 16 18:36:29 centos7 kubelet[20135]: I1116 18:36:29.375005   20135 manager.go:281] Starting recovery of all containers
    11月 16 18:36:29 centos7 kubelet[20135]: I1116 18:36:29.375814   20135 manager.go:286] Recovery completed
    11月 16 18:36:29 centos7 kubelet[20135]: I1116 18:36:29.386537   20135 kubelet.go:2924] Recording NodeReady event message for node 192.168.39.100
    11月 16 18:36:34 centos7 kubelet[20135]: I1116 18:36:34.122062   20135 kubelet.go:2566] SyncLoop (ADD, "file"): ""
    11月 16 18:36:34 centos7 kubelet[20135]: I1116 18:36:34.122126   20135 kubelet.go:2566] SyncLoop (ADD, "api"): ""

Setup `kube-proxy`

    [root@centos7 ~]# cp kubernetes/1.3.10/centos/systemd/system/kube-proxy.service /etc/systemd/system

    [root@centos7 ~]# vi kubernetes/1.3.10/centos/systemd/conf/kube-proxy

    [root@centos7 ~]# cp kubernetes/1.3.10/centos/systemd/conf/kube-proxy /etc/sysconfig/

    [root@centos7 ~]# systemctl enable kube-proxy.service
    Created symlink from /etc/systemd/system/multi-user.target.wants/kube-proxy.service to /etc/systemd/system/kube-proxy.service.

    [root@centos7 ~]# systemctl start kube-proxy.service

    [root@centos7 ~]# systemctl -l status kube-proxy.service
    ● kube-proxy.service - Kubernetes proxy networking
       Loaded: loaded (/etc/systemd/system/kube-proxy.service; enabled; vendor preset: disabled)
       Active: active (running) since 三 2016-11-16 18:39:58 CST; 10s ago
         Docs: https://github.com/kubernetes/kubernetes
     Main PID: 20529 (kube-proxy)
       CGroup: /system.slice/kube-proxy.service
               └─20529 /opt/kubernetes/server/bin/kube-proxy --bind-address=192.168.39.100 --cluster-cidr=10.120.0.0/14 --healthz-bind-address=127.0.0.1 --healthz-port=10249 --hostname-override=192.168.39.100 --iptables-masquerade-bit=14 --kubeconfig=/etc/kubernetes/kubeconfig --master=https://192.168.39.99:6443 --v=2

    11月 16 18:39:58 centos7 kube-proxy[20529]: I1116 18:39:58.943976   20529 server.go:155] setting OOM scores is unsupported in this build
    11月 16 18:39:59 centos7 kube-proxy[20529]: I1116 18:39:59.010762   20529 server.go:202] Using iptables Proxier.
    11月 16 18:39:59 centos7 kube-proxy[20529]: I1116 18:39:59.014183   20529 proxier.go:216] missing br-netfilter module or unset br-nf-call-iptables; proxy may not work as intended
    11月 16 18:39:59 centos7 kube-proxy[20529]: I1116 18:39:59.014239   20529 server.go:214] Tearing down userspace rules.
    11月 16 18:39:59 centos7 kube-proxy[20529]: I1116 18:39:59.035077   20529 conntrack.go:40] Setting nf_conntrack_max to 1048576
    11月 16 18:39:59 centos7 kube-proxy[20529]: I1116 18:39:59.036283   20529 conntrack.go:57] Setting conntrack hashsize to 262144
    11月 16 18:39:59 centos7 kube-proxy[20529]: I1116 18:39:59.037568   20529 conntrack.go:62] Setting nf_conntrack_tcp_timeout_established to 86400
    11月 16 18:39:59 centos7 kube-proxy[20529]: I1116 18:39:59.037858   20529 proxier.go:440] Adding new service "default/kubernetes:https" at 10.123.240.1:443/TCP
    11月 16 18:39:59 centos7 kube-proxy[20529]: I1116 18:39:59.038096   20529 proxier.go:674] Not syncing iptables until Services and Endpoints have been received from master
    11月 16 18:39:59 centos7 kube-proxy[20529]: I1116 18:39:59.040693   20529 proxier.go:516] Setting endpoints for "default/kubernetes:https" to [192.168.39.99:6443]

Validation

    [root@centos7 ~]# kubectl get nodes
    NAME             STATUS    AGE
    192.168.39.100   Ready     4m
    192.168.39.99    Ready     45m

配置  POD networking

    [root@centos7 ~]# vi /etc/sysconfig/flanneld

    [root@centos7 ~]# systemctl enable flanneld.service
    Created symlink from /etc/systemd/system/multi-user.target.wants/flanneld.service to /usr/lib/systemd/system/flanneld.service.
    Created symlink from /etc/systemd/system/docker.service.requires/flanneld.service to /usr/lib/systemd/system/flanneld.service.

    [root@centos7 ~]# ip a show dockero
    Device "dockero" does not exist.

    [root@centos7 ~]# ip a show docker0
    9: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN
        link/ether 02:42:ff:91:b9:7d brd ff:ff:ff:ff:ff:ff
        inet 172.17.0.1/16 scope global docker0
           valid_lft forever preferred_lft forever

    [root@centos7 ~]# systemctl start flanneld.service

    [root@centos7 ~]# systemctl -l status flanneld.service
    ● flanneld.service - Flanneld overlay address etcd agent
       Loaded: loaded (/usr/lib/systemd/system/flanneld.service; enabled; vendor preset: disabled)
       Active: active (running) since 四 2016-11-17 18:07:04 CST; 7s ago
      Process: 29760 ExecStartPost=/usr/libexec/flannel/mk-docker-opts.sh -k DOCKER_NETWORK_OPTIONS -d /run/flannel/docker (code=exited, status=0/SUCCESS)
     Main PID: 29749 (flanneld)
       CGroup: /system.slice/flanneld.service
               └─29749 /usr/bin/flanneld -etcd-endpoints=http://192.168.39.99:2379 -etcd-prefix=/cmri.com/network -iface=192.168.39.100

    11月 17 18:07:04 centos7 systemd[1]: Starting Flanneld overlay address etcd agent...
    11月 17 18:07:04 centos7 flanneld[29749]: I1117 18:07:04.176414 29749 main.go:275] Installing signal handlers
    11月 17 18:07:04 centos7 flanneld[29749]: I1117 18:07:04.178547 29749 main.go:188] Using 192.168.39.100 as external interface
    11月 17 18:07:04 centos7 flanneld[29749]: I1117 18:07:04.178606 29749 main.go:189] Using 192.168.39.100 as external endpoint
    11月 17 18:07:04 centos7 flanneld[29749]: I1117 18:07:04.182969 29749 etcd.go:204] Picking subnet in range 10.120.2.0 ... 10.121.254.0
    11月 17 18:07:04 centos7 flanneld[29749]: I1117 18:07:04.184185 29749 etcd.go:84] Subnet lease acquired: 10.120.132.0/23
    11月 17 18:07:04 centos7 flanneld[29749]: I1117 18:07:04.195642 29749 udp.go:222] Watching for new subnet leases
    11月 17 18:07:04 centos7 flanneld[29749]: I1117 18:07:04.197550 29749 udp.go:247] Subnet added: 10.120.138.0/23
    11月 17 18:07:04 centos7 systemd[1]: Started Flanneld overlay address etcd agent.

    [root@centos7 ~]# systemctl restart docker.service

    [root@centos7 ~]# ip addr show docker0
    9: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN
        link/ether 02:42:ff:91:b9:7d brd ff:ff:ff:ff:ff:ff
        inet 10.120.132.1/23 scope global docker0
           valid_lft forever preferred_lft forever

    [root@centos7 ~]# ping -c3 10.120.138.1
    PING 10.120.138.1 (10.120.138.1) 56(84) bytes of data.
    64 bytes from 10.120.138.1: icmp_seq=1 ttl=62 time=1.13 ms
    64 bytes from 10.120.138.1: icmp_seq=2 ttl=62 time=0.357 ms
    64 bytes from 10.120.138.1: icmp_seq=3 ttl=62 time=0.391 ms

    --- 10.120.138.1 ping statistics ---
    3 packets transmitted, 3 received, 0% packet loss, time 2001ms
    rtt min/avg/max/mdev = 0.357/0.628/1.136/0.359 ms
