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

    [root@centos7 ~]# cat /etc/resolv.conf
    nameserver 8.8.8.8

关闭firewall

    [root@centos7 ~]# systemctl -l status firewalld.service
    ● firewalld.service - firewalld - dynamic firewall daemon
       Loaded: loaded (/usr/lib/systemd/system/firewalld.service; enabled; vendor preset: enabled)
       Active: active (running) since 五 2016-11-11 16:45:58 CST; 5 days ago
     Main PID: 32729 (firewalld)
       CGroup: /system.slice/firewalld.service
               └─32729 /usr/bin/python -Es /usr/sbin/firewalld --nofork --nopid

    11月 16 17:55:50 centos7 firewalld[32729]: 2016-11-16 17:55:50 ERROR: COMMAND_FAILED: '/sbin/iptables -w2 -t nat -C POSTROUTING -s 172.17.0.0/16 ! -o docker0 -j MASQUERADE' failed: iptables: No chain/target/match by that name.
    11月 16 17:55:50 centos7 firewalld[32729]: 2016-11-16 17:55:50 ERROR: COMMAND_FAILED: '/sbin/iptables -w2 -t nat -C DOCKER -i docker0 -j RETURN' failed: iptables: Bad rule (does a matching rule exist in that chain?).
    11月 16 17:55:50 centos7 firewalld[32729]: 2016-11-16 17:55:50 ERROR: COMMAND_FAILED: '/sbin/iptables -w2 -D FORWARD -i docker0 -o docker0 -j DROP' failed: iptables: Bad rule (does a matching rule exist in that chain?).
    11月 16 17:55:50 centos7 firewalld[32729]: 2016-11-16 17:55:50 ERROR: COMMAND_FAILED: '/sbin/iptables -w2 -t filter -C FORWARD -i docker0 -o docker0 -j ACCEPT' failed: iptables: Bad rule (does a matching rule exist in that chain?).
    11月 16 17:55:50 centos7 firewalld[32729]: 2016-11-16 17:55:50 ERROR: COMMAND_FAILED: '/sbin/iptables -w2 -t filter -C FORWARD -i docker0 ! -o docker0 -j ACCEPT' failed: iptables: Bad rule (does a matching rule exist in that chain?).
    11月 16 17:55:50 centos7 firewalld[32729]: 2016-11-16 17:55:50 ERROR: COMMAND_FAILED: '/sbin/iptables -w2 -t filter -C FORWARD -o docker0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT' failed: iptables: Bad rule (does a matching rule exist in that chain?).
    11月 16 17:55:50 centos7 firewalld[32729]: 2016-11-16 17:55:50 ERROR: COMMAND_FAILED: '/sbin/iptables -w2 -t nat -C PREROUTING -m addrtype --dst-type LOCAL -j DOCKER' failed: iptables: No chain/target/match by that name.
    11月 16 17:55:50 centos7 firewalld[32729]: 2016-11-16 17:55:50 ERROR: COMMAND_FAILED: '/sbin/iptables -w2 -t nat -C OUTPUT -m addrtype --dst-type LOCAL -j DOCKER ! --dst 127.0.0.0/8' failed: iptables: No chain/target/match by that name.
    11月 16 17:55:50 centos7 firewalld[32729]: 2016-11-16 17:55:50 ERROR: COMMAND_FAILED: '/sbin/iptables -w2 -t filter -C FORWARD -o docker0 -j DOCKER' failed: iptables: No chain/target/match by that name.
    11月 16 17:55:50 centos7 firewalld[32729]: 2016-11-16 17:55:50 ERROR: COMMAND_FAILED: '/sbin/iptables -w2 -t filter -C FORWARD -j DOCKER-ISOLATION' failed: iptables: No chain/target/match by that name.
    [root@centos7 ~]# systemctl stop firewalld.service

    [root@centos7 ~]# systemctl disable firewalld.service
    Removed symlink /etc/systemd/system/dbus-org.fedoraproject.FirewallD1.service.
    Removed symlink /etc/systemd/system/basic.target.wants/firewalld.service.

安装软件包docker, etcd, flannel
-------------------------------

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

Setup `etcd` service

    [root@centos7 ~]# vi /etc/etcd/etcd.conf
    ETCD_NAME=k8s-cw-project
    ETCD_DATA_DIR="/var/lib/etcd/k8s-cw-project.etcd"
    ETCD_LISTEN_PEER_URLS="http://192.168.39.99:2380"
    ETCD_LISTEN_CLIENT_URLS="http://0.0.0.0:2379"
    ETCD_INITIAL_ADVERTISE_PEER_URLS="http://192.168.39.99:2380"
    ETCD_INITIAL_CLUSTER="k8s-cw-project=http://192.168.39.99:2380"
    ETCD_ADVERTISE_CLIENT_URLS="http://192.168.39.99:2379"


    [root@centos7 ~]# systemctl enable etcd.service
    Created symlink from /etc/systemd/system/multi-user.target.wants/etcd.service to /usr/lib/systemd/system/etcd.service.
    [root@centos7 ~]# systemctl start etcd.service

    [root@centos7 ~]# systemctl -l status etcd.service
    ● etcd.service - Etcd Server
       Loaded: loaded (/usr/lib/systemd/system/etcd.service; enabled; vendor preset: disabled)
       Active: active (running) since 三 2016-11-16 16:37:10 CST; 55s ago
     Main PID: 11026 (etcd)
       CGroup: /system.slice/etcd.service
               └─11026 /usr/bin/etcd --name=k8s-cw-project --data-dir=/var/lib/etcd/k8s-cw-project.etcd --listen-client-urls=http://0.0.0.0:2379

     [root@centos7 ~]# ls /var/lib/etcd
     k8s-cw-project.etcd

     [root@centos7 ~]# curl http://192.168.39.99:2379/version
     {"etcdserver":"2.3.7","etcdcluster":"2.3.0"}

     [root@centos7 ~]# sudo netstat -tpnl
     Active Internet connections (only servers)
     Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
     tcp        0      0 192.168.39.99:2380      0.0.0.0:*               LISTEN      11026/etcd          
     tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN      22576/rpcbind       
     tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      741/sshd            
     tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN      2762/master         
     tcp6       0      0 :::2379                 :::*                    LISTEN      11026/etcd          
     tcp6       0      0 :::111                  :::*                    LISTEN      22576/rpcbind       
     tcp6       0      0 :::22                   :::*                    LISTEN      741/sshd            
     tcp6       0      0 ::1:25                  :::*                    LISTEN      2762/master       

安装kubernetes
---------------

Download `kubernetes` packages

    fanhonglingdeMacBook-Pro:trusty64 fanhongling$ scp -r /Volumes/TOURO\ Mobile/kubernetes/{kube,kubernetes,kubernetes.tar.gz} root@192.168.39.99:/root

    [root@centos7 ~]# tar -C /opt -zxf kubernetes.tar.gz kubernetes/server/kubernetes-server-linux-amd64.tar.gz
    [root@centos7 ~]# tar -C /opt -zxf /opt/kubernetes/server/kubernetes-server-linux-amd64.tar.gz

    [root@centos7 ~]# /opt/kubernetes/server/bin/kubelet --version
    Kubernetes v1.3.10

Generate CA and certs

    [root@centos7 ~]# vi salt-make-ca-cert.sh

    root@centos7 ~]# ./salt-make-ca-cert.sh
    IP:192.168.39.99,IP:10.123.240.1,DNS:kubernetes,DNS:kubernetes.default,DNS:kubernetes.default.svc,DNS:kubernetes.default.svc.cluster.local
    Generate ca certs into /root/.kube/cacerts

Setup `kube-apiserver` servie

    [root@centos7 ~]# cp kubernetes/1.3.10/centos/systemd/system/kube-apiserver.service /etc/systemd/system

    [root@centos7 ~]# vi kubernetes/1.3.10/centos/systemd/conf/kube-apiserver

    [root@centos7 ~]# cp kubernetes/1.3.10/centos/systemd/conf/kube-apiserver /etc/sysconfig/

    [root@centos7 ~]# systemctl enable kube-apiserver.service
    Created symlink from /etc/systemd/system/multi-user.target.wants/kube-apiserver.service to /etc/systemd/system/kube-apiserver.service.
    [root@centos7 ~]# systemctl start kube-apiserver.service
    [root@centos7 ~]# systemctl -l status kube-apiserver.service
    ● kube-apiserver.service - Kubernetes API server
       Loaded: loaded (/etc/systemd/system/kube-apiserver.service; enabled; vendor preset: disabled)
       Active: active (running) since 三 2016-11-16 16:39:36 CST; 7s ago
         Docs: https://github.com/kubernetes/kubernetes
     Main PID: 11113 (kube-apiserver)
       CGroup: /system.slice/kube-apiserver.service
               └─11113 /opt/kubernetes/server/bin/kube-apiserver --admission-control=AlwaysAdmit --advertise-address=192.168.39.99 --allow-privileged=true --apiserver-count=1 --bind-address=0.0.0.0 --cert-dir=/opt/kubernetes/cacerts --client-ca-file=/opt/kubernetes/cacerts/ca.crt --enable-garbage-collector=false --enable-swagger-ui=false --etcd-servers=http://192.168.39.99:2379 --insecure-bind-address=127.0.0.1 --insecure-port=8080 --kubelet-certificate-authority=/opt/kubernetes/cacerts/ca.crt --kubelet-client-certificate=/opt/kubernetes/cacerts/kubecfg.crt --kubelet-client-key=/opt/kubernetes/cacerts/kubecfg.key --kubelet-https=true --master-service-namespace=default --runtime-config=api/all=true --secure-port=6443 --service-account-key-file=/opt/kubernetes/cacerts/server.key --service-cluster-ip-range=10.123.240.0/20 --tls-cert-file=/opt/kubernetes/cacerts/server.cert --tls-private-key-file=/opt/kubernetes/cacerts/server.key --v=2

    11月 16 16:39:36 centos7 systemd[1]: Starting Kubernetes API server...
    11月 16 16:39:36 centos7 kube-apiserver[11113]: I1116 16:39:36.163537   11113 genericapiserver.go:606] Will report 192.168.39.99 as public IP address.
    11月 16 16:39:36 centos7 kube-apiserver[11113]: I1116 16:39:36.168134   11113 genericapiserver.go:288] Node port range unspecified. Defaulting to 30000-32767.
    11月 16 16:39:36 centos7 kube-apiserver[11113]: W1116 16:39:36.240952   11113 controller.go:307] Resetting endpoints for master service "kubernetes" to kind:"" apiVersion:""
    11月 16 16:39:36 centos7 kube-apiserver[11113]: [restful] 2016/11/16 16:39:36 log.go:30: [restful/swagger] listing is available at https://192.168.39.99:6443/swaggerapi/
    11月 16 16:39:36 centos7 kube-apiserver[11113]: [restful] 2016/11/16 16:39:36 log.go:30: [restful/swagger] https://192.168.39.99:6443/swaggerui/ is mapped to folder /swagger-ui/
    11月 16 16:39:36 centos7 kube-apiserver[11113]: I1116 16:39:36.268253   11113 genericapiserver.go:690] Serving securely on 0.0.0.0:6443
    11月 16 16:39:36 centos7 kube-apiserver[11113]: I1116 16:39:36.268276   11113 genericapiserver.go:734] Serving insecurely on 127.0.0.1:8080
    11月 16 16:39:36 centos7 systemd[1]: Started Kubernetes API server.

    [root@centos7 ~]# sudo netstat -tpnl
    Active Internet connections (only servers)
    Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
    tcp        0      0 192.168.39.99:2380      0.0.0.0:*               LISTEN      11026/etcd          
    tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN      22576/rpcbind       
    tcp        0      0 127.0.0.1:8080          0.0.0.0:*               LISTEN      11113/kube-apiserve
    tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      741/sshd            
    tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN      2762/master         
    tcp6       0      0 :::6443                 :::*                    LISTEN      11113/kube-apiserve
    tcp6       0      0 :::2379                 :::*                    LISTEN      11026/etcd          
    tcp6       0      0 :::111                  :::*                    LISTEN      22576/rpcbind       
    tcp6       0      0 :::22                   :::*                    LISTEN      741/sshd            
    tcp6       0      0 ::1:25                  :::*                    LISTEN      2762/master         

    [root@centos7 ~]# etcdctl ls
    /registry

    [root@centos7 ~]# etcdctl ls --recursive /registry
    /registry/ranges
    /registry/ranges/serviceips
    /registry/ranges/servicenodeports
    /registry/namespaces
    /registry/namespaces/default
    /registry/namespaces/kube-system
    /registry/services
    /registry/services/specs
    /registry/services/specs/default
    /registry/services/specs/default/kubernetes
    /registry/services/endpoints
    /registry/services/endpoints/default
    /registry/services/endpoints/default/kubernetes

    [root@centos7 ~]# curl http://127.0.0.1:8080
    {
      "paths": [
        "/api",
        "/api/v1",
        "/apis",
        "/apis/apps",
        "/apis/apps/v1alpha1",
        "/apis/autoscaling",
        "/apis/autoscaling/v1",
        "/apis/batch",
        "/apis/batch/v1",
        "/apis/batch/v2alpha1",
        "/apis/extensions",
        "/apis/extensions/v1beta1",
        "/apis/policy",
        "/apis/policy/v1alpha1",
        "/apis/rbac.authorization.k8s.io",
        "/apis/rbac.authorization.k8s.io/v1alpha1",
        "/healthz",
        "/healthz/ping",
        "/logs/",
        "/metrics",
        "/swaggerapi/",
        "/ui/",
        "/version"
      ]
    }

Setup `kubectl` tool

    [root@centos7 ~]# mkdir bin

    [root@centos7 ~]# ln -s /opt/kubernetes/server/bin/kubectl bin/

    [root@centos7 ~]# kubectl config set-cluster kube --server=https://192.168.39.99:6443
    cluster "kube" set.

    [root@centos7 ~]# encoded=$(sudo base64 -w0 /opt/kubernetes/cacerts/ca.crt); kubectl config set clusters.kube.certificate-authority-data "$encoded"
    property "clusters.kube.certificate-authority-data" set.

    [root@centos7 ~]# kubectl config set-credentials admin
    user "admin" set.

    [root@centos7 ~]# encoded=$(sudo base64 -w0 /opt/kubernetes/cacerts/kubecfg.crt); kubectl config set users.admin.client-certificate-data "$encoded"
    property "users.admin.client-certificate-data" set.

    [root@centos7 ~]# encoded=$(sudo base64 -w0 /opt/kubernetes/cacerts/kubecfg.key); kubectl config set users.admin.client-key-data "$encoded"
    property "users.admin.client-key-data" set.

    [root@centos7 ~]# kubectl config set-context kube-admin --cluster=kube --user=admin
    context "kube-admin" set.

    [root@centos7 ~]# kubectl version
    Client Version: version.Info{Major:"1", Minor:"3", GitVersion:"v1.3.10", GitCommit:"c3e367ec9eae7338ac4e2a57f293634891319b7c", GitTreeState:"clean", BuildDate:"2016-10-31T21:25:43Z", GoVersion:"go1.6.2", Compiler:"gc", Platform:"linux/amd64"}
    Server Version: version.Info{Major:"1", Minor:"3", GitVersion:"v1.3.10", GitCommit:"c3e367ec9eae7338ac4e2a57f293634891319b7c", GitTreeState:"clean", BuildDate:"2016-10-31T21:06:41Z", GoVersion:"go1.6.2", Compiler:"gc", Platform:"linux/amd64"}

    [root@centos7 ~]# kubectl api-versions
    apps/v1alpha1
    autoscaling/v1
    batch/v1
    batch/v2alpha1
    extensions/v1beta1
    policy/v1alpha1
    rbac.authorization.k8s.io/v1alpha1
    v1

Setup `kube-controller-manager` service

    [root@centos7 ~]# mkdir /etc/kubernetes

    [root@centos7 ~]# cp ~/.kube/config /etc/kubernetes/kubeconfig


    [root@centos7 ~]# cp kubernetes/1.3.10/centos/systemd/system/kube-controller-manager.service /etc/systemd/system
    [root@centos7 ~]# vi kubernetes/1.3.10/centos/systemd/conf/kube-controller-manager
    [root@centos7 ~]# cp kubernetes/1.3.10/centos/systemd/conf/kube-controller-manager /etc/sysconfig/
    [root@centos7 ~]# systemctl enable kube-controller-manager
    Created symlink from /etc/systemd/system/multi-user.target.wants/kube-controller-manager.service to /etc/systemd/system/kube-controller-manager.service.
    [root@centos7 ~]# systemctl start kube-controller-manager
    [root@centos7 ~]# systemctl -l status kube-controller-manager


    [root@centos7 ~]# systemctl -l status kube-controller-manager
    ● kube-controller-manager.service - Kubernetes controller manager
       Loaded: loaded (/etc/systemd/system/kube-controller-manager.service; enabled; vendor preset: disabled)
       Active: active (running) since 三 2016-11-16 16:57:31 CST; 10s ago
         Docs: https://github.com/kubernetes/kubernetes
     Main PID: 12095 (kube-controller)
       CGroup: /system.slice/kube-controller-manager.service
               └─12095 /opt/kubernetes/server/bin/kube-controller-manager --address=192.168.39.99 --cluster-cidr=10.120.0.0/14 --cluster-name=kubernetes --enable-garbage-collector=false --kubeconfig=/etc/kubernetes/kubeconfig --master=https://192.168.39.99:6443 --port=10252 --root-ca-file=/opt/kubernetes/cacerts/ca.crt --service-account-private-key-file=/opt/kubernetes/cacerts/server.key --service-cluster-ip-range=10.123.240.0/20 --v=2

Setup `kube-scheduler` service

    [root@centos7 ~]# cp kubernetes/1.3.10/centos/systemd/system/kube-scheduler.service /etc/systemd/system

    [root@centos7 ~]# vim kubernetes/1.3.10/centos/systemd/conf/kube-scheduler

    [root@centos7 ~]# cp kubernetes/1.3.10/centos/systemd/conf/kube-scheduler /etc/sysconfig/

    [root@centos7 ~]# systemctl enable kube-scheduler.service
    Created symlink from /etc/systemd/system/multi-user.target.wants/kube-scheduler.service to /etc/systemd/system/kube-scheduler.service.

    [root@centos7 ~]# systemctl start kube-scheduler.service

    [root@centos7 ~]# systemctl -l status kube-scheduler.service
    ● kube-scheduler.service - Kubernetes scheduler
       Loaded: loaded (/etc/systemd/system/kube-scheduler.service; enabled; vendor preset: disabled)
       Active: active (running) since 三 2016-11-16 17:14:37 CST; 7s ago
         Docs: https://github.com/kubernetes/kubernetes
     Main PID: 12651 (kube-scheduler)
       CGroup: /system.slice/kube-scheduler.service
               └─12651 /opt/kubernetes/server/bin/kube-scheduler --address=192.168.39.99 --algorithm-provider=DefaultProvider --kubeconfig=/etc/kubernetes/kubeconfig --master=https://192.168.39.99:6443 --port=10251 --scheduler-name=default-scheduler --v=2

    11月 16 17:14:37 centos7 systemd[1]: Started Kubernetes scheduler.
    11月 16 17:14:37 centos7 systemd[1]: Starting Kubernetes scheduler...
    11月 16 17:14:37 centos7 kube-scheduler[12651]: I1116 17:14:37.371217   12651 factory.go:255] Creating scheduler from algorithm provider 'DefaultProvider'
    11月 16 17:14:37 centos7 kube-scheduler[12651]: I1116 17:14:37.371443   12651 factory.go:301] creating scheduler with fit predicates 'map[NoDiskConflict:{} NoVolumeZoneConflict:{} MaxEBSVolumeCount:{} MaxGCEPDVolumeCount:{} GeneralPredicates:{} PodToleratesNodeTaints:{} CheckNodeMemoryPressure:{}]' and priority functions 'map[BalancedResourceAllocation:{} SelectorSpreadPriority:{} NodeAffinityPriority:{} TaintTolerationPriority:{} LeastRequestedPriority:{}]

Setup `kubelet` service

    [root@centos7 ~]# cp kubernetes/1.3.10/centos/systemd/system/kubelet.service /etc/systemd/system

    [root@centos7 ~]# vi kubernetes/1.3.10/centos/systemd/conf/kubelet

    [root@centos7 ~]# cp kubernetes/1.3.10/centos/systemd/conf/kubelet /etc/sysconfig/

    [root@centos7 ~]# systemctl start kubelet.service

    [root@centos7 ~]# systemctl -l status kubelet.service
    ● kubelet.service - Kubernetes container mgmt daemon - kubelet
       Loaded: loaded (/etc/systemd/system/kubelet.service; enabled; vendor preset: disabled)
       Active: active (running) since 三 2016-11-16 17:55:50 CST; 9s ago
         Docs: https://github.com/kubernetes/kubernetes
      Process: 14085 ExecStartPre=/usr/bin/mkdir -p /var/log/containers (code=exited, status=0/SUCCESS)
      Process: 14080 ExecStartPre=/usr/bin/mkdir -p /etc/kubernetes/manifests (code=exited, status=0/SUCCESS)
     Main PID: 14090 (kubelet)
       CGroup: /system.slice/kubelet.service
               ├─14090 /opt/kubernetes/server/bin/kubelet --address=192.168.39.99 --allow-privileged=true --api-servers=https://192.168.39.99:6443 --cadvisor-port=4194 --cert-dir=/opt/kubernetes/cacerts --cluster-dns=10.123.240.10 --cluster-domain=cluster.local --config=/etc/kubernetes/manifests --configure-cbr0=false --container-runtime=docker --docker=unix:///var/run/docker.sock --healthz-bind-address=127.0.0.1 --healthz-port=10248 --hostname-override=192.168.39.99 --kubeconfig=/etc/kubernetes/kubeconfig --master-service-namespace=default --max-open-files=1000000 --max-pods=0 --node-ip=192.168.39.99 --non-masquerade-cidr=10.0.0.0/8 --pod-infra-container-image=gcr.io/google_containers/pause-amd64:3.0 --pods-per-core=0 --port=10250 --read-only-port=10255 --root-dir=/var/lib/kubelet --tls-cert-file=/opt/kubernetes/cacerts/server.cert --tls-private-key-file=/opt/kubernetes/cacerts/server.key --v=2
               └─14173 journalctl -k -f

    11月 16 17:55:51 centos7 kubelet[14090]: E1116 17:55:51.869844   14090 manager.go:240] Registration of the rkt container factory failed: unable to communicate with Rkt api service: rkt: cannot tcp Dial rkt api service: dial tcp [::1]:15441: getsockopt: connection refused
    11月 16 17:55:51 centos7 kubelet[14090]: I1116 17:55:51.869854   14090 factory.go:54] Registering systemd factory
    11月 16 17:55:51 centos7 kubelet[14090]: I1116 17:55:51.870428   14090 factory.go:86] Registering Raw factory
    11月 16 17:55:51 centos7 kubelet[14090]: I1116 17:55:51.871001   14090 manager.go:1072] Started watching for new ooms in manager
    11月 16 17:55:51 centos7 kubelet[14090]: I1116 17:55:51.872466   14090 oomparser.go:185] oomparser using systemd
    11月 16 17:55:51 centos7 kubelet[14090]: I1116 17:55:51.873417   14090 manager.go:281] Starting recovery of all containers
    11月 16 17:55:51 centos7 kubelet[14090]: I1116 17:55:51.874231   14090 manager.go:286] Recovery completed
    11月 16 17:55:51 centos7 kubelet[14090]: I1116 17:55:51.893660   14090 kubelet.go:2924] Recording NodeReady event message for node 192.168.39.99
    11月 16 17:55:56 centos7 kubelet[14090]: I1116 17:55:56.626543   14090 kubelet.go:2566] SyncLoop (ADD, "file"): ""
    11月 16 17:55:56 centos7 kubelet[14090]: I1116 17:55:56.626609   14090 kubelet.go:2566] SyncLoop (ADD, "api"): ""

Setup `kube-proxy` service

    [root@centos7 ~]# cp kubernetes/1.3.10/centos/systemd/system/kube-proxy.service /etc/systemd/system

    [root@centos7 ~]# vi kubernetes/1.3.10/centos/systemd/conf/kube-proxy

    [root@centos7 ~]# cp kubernetes/1.3.10/centos/systemd/conf/kube-proxy /etc/sysconfig/

    [root@centos7 ~]# systemctl enable kube-proxy.service
    Created symlink from /etc/systemd/system/multi-user.target.wants/kube-proxy.service to /etc/systemd/system/kube-proxy.service.

    [root@centos7 ~]# systemctl start kube-proxy.service

    [root@centos7 ~]# systemctl -l status kube-proxy.service
    ● kube-proxy.service - Kubernetes proxy networking
       Loaded: loaded (/etc/systemd/system/kube-proxy.service; enabled; vendor preset: disabled)
       Active: active (running) since 三 2016-11-16 17:59:21 CST; 6s ago
         Docs: https://github.com/kubernetes/kubernetes
     Main PID: 14464 (kube-proxy)
       CGroup: /system.slice/kube-proxy.service
               └─14464 /opt/kubernetes/server/bin/kube-proxy --bind-address=192.168.39.99 --cluster-cidr=10.120.0.0/14 --healthz-bind-address=127.0.0.1 --healthz-port=10249 --hostname-override=192.168.39.99 --iptables-masquerade-bit=14 --kubeconfig=/etc/kubernetes/kubeconfig --master=https://192.168.39.99:6443 --v=2

    11月 16 17:59:21 centos7 kube-proxy[14464]: I1116 17:59:21.474030   14464 server.go:155] setting OOM scores is unsupported in this build
    11月 16 17:59:21 centos7 kube-proxy[14464]: I1116 17:59:21.548175   14464 server.go:202] Using iptables Proxier.
    11月 16 17:59:21 centos7 kube-proxy[14464]: I1116 17:59:21.550990   14464 proxier.go:216] missing br-netfilter module or unset br-nf-call-iptables; proxy may not work as intended
    11月 16 17:59:21 centos7 kube-proxy[14464]: I1116 17:59:21.551040   14464 server.go:214] Tearing down userspace rules.
    11月 16 17:59:21 centos7 kube-proxy[14464]: I1116 17:59:21.570054   14464 conntrack.go:40] Setting nf_conntrack_max to 1048576
    11月 16 17:59:21 centos7 kube-proxy[14464]: I1116 17:59:21.571014   14464 conntrack.go:57] Setting conntrack hashsize to 262144
    11月 16 17:59:21 centos7 kube-proxy[14464]: I1116 17:59:21.572178   14464 conntrack.go:62] Setting nf_conntrack_tcp_timeout_established to 86400
    11月 16 17:59:21 centos7 kube-proxy[14464]: I1116 17:59:21.572726   14464 proxier.go:440] Adding new service "default/kubernetes:https" at 10.123.240.1:443/TCP
    11月 16 17:59:21 centos7 kube-proxy[14464]: I1116 17:59:21.572950   14464 proxier.go:674] Not syncing iptables until Services and Endpoints have been received from master
    11月 16 17:59:21 centos7 kube-proxy[14464]: I1116 17:59:21.575306   14464 proxier.go:516] Setting endpoints for "default/kubernetes:https" to [192.168.39.99:6443]

Validation

    [root@centos7 ~]# kubectl get nodes
    NAME            STATUS    AGE
    192.168.39.99   Ready     4m

配置 containers networking
--------------------------

    [root@centos7 ~]# etcdctl set /cmri.com/network/config '{
    >   "Network": "10.120.0.0/15",
    >   "SubnetLen": 23,
    >   "SubnetMax": "10.121.254.0",
    >   "Backend": {
    >     "Type": "udp"
    >   }
    > }'
    {
      "Network": "10.120.0.0/15",
      "SubnetLen": 23,
      "SubnetMax": "10.121.254.0",
      "Backend": {
        "Type": "udp"
      }
    }

    [root@centos7 ~]# vi /etc/sysconfig/flanneld

    [root@centos7 ~]# vi /etc/sysconfig/flanneld

    [root@centos7 ~]# systemctl enable flanneld.service
    Created symlink from /etc/systemd/system/multi-user.target.wants/flanneld.service to /usr/lib/systemd/system/flanneld.service.
    Created symlink from /etc/systemd/system/docker.service.requires/flanneld.service to /usr/lib/systemd/system/flanneld.service.

    [root@centos7 ~]# systemctl start flanneld.service

    [root@centos7 ~]# systemctl -l status flanneld.service
    ● flanneld.service - Flanneld overlay address etcd agent
       Loaded: loaded (/usr/lib/systemd/system/flanneld.service; enabled; vendor preset: disabled)
       Active: active (running) since 四 2016-11-17 17:34:01 CST; 9s ago
      Process: 22279 ExecStartPost=/usr/libexec/flannel/mk-docker-opts.sh -k DOCKER_NETWORK_OPTIONS -d /run/flannel/docker (code=exited, status=0/SUCCESS)
     Main PID: 22265 (flanneld)
       CGroup: /system.slice/flanneld.service
               └─22265 /usr/bin/flanneld -etcd-endpoints=http://192.168.39.99:2379 -etcd-prefix=/cmri.com/network

    11月 17 17:34:01 centos7 systemd[1]: Starting Flanneld overlay address etcd agent...
    11月 17 17:34:01 centos7 flanneld[22265]: I1117 17:34:01.622452 22265 main.go:275] Installing signal handlers
    11月 17 17:34:01 centos7 flanneld[22265]: I1117 17:34:01.622617 22265 main.go:130] Determining IP address of default interface
    11月 17 17:34:01 centos7 flanneld[22265]: I1117 17:34:01.623969 22265 main.go:188] Using 192.168.39.99 as external interface
    11月 17 17:34:01 centos7 flanneld[22265]: I1117 17:34:01.624003 22265 main.go:189] Using 192.168.39.99 as external endpoint
    11月 17 17:34:01 centos7 flanneld[22265]: I1117 17:34:01.627055 22265 etcd.go:204] Picking subnet in range 10.120.2.0 ... 10.121.254.0
    11月 17 17:34:01 centos7 flanneld[22265]: I1117 17:34:01.628088 22265 etcd.go:84] Subnet lease acquired: 10.120.138.0/23
    11月 17 17:34:01 centos7 flanneld[22265]: I1117 17:34:01.645257 22265 udp.go:222] Watching for new subnet leases
    11月 17 17:34:01 centos7 systemd[1]: Started Flanneld overlay address etcd agent.

    [root@centos7 ~]# cat /var/run/flannel/subnet.env
    FLANNEL_NETWORK=10.120.0.0/15
    FLANNEL_SUBNET=10.120.138.1/23
    FLANNEL_MTU=1472
    FLANNEL_IPMASQ=false

    [root@centos7 ~]# sudo systemctl enable docker.service
    Created symlink from /etc/systemd/system/multi-user.target.wants/docker.service to /usr/lib/systemd/system/docker.service.
    [root@centos7 ~]# sudo systemctl restart docker.service
    [root@centos7 ~]# sudo systemctl -l status docker.service
    ● docker.service - Docker Application Container Engine
       Loaded: loaded (/usr/lib/systemd/system/docker.service; enabled; vendor preset: disabled)
      Drop-In: /usr/lib/systemd/system/docker.service.d
               └─flannel.conf
       Active: active (running) since 四 2016-11-17 17:36:16 CST; 9s ago
         Docs: http://docs.docker.com
     Main PID: 22540 (docker-current)
       CGroup: /system.slice/docker.service
               └─22540 /usr/bin/docker-current daemon --exec-opt native.cgroupdriver=systemd --selinux-enabled --log-driver=journald --storage-driver devicemapper --storage-opt dm.fs=xfs --storage-opt dm.thinpooldev=/dev/mapper/vg_data-docker--pool --storage-opt dm.use_deferred_removal=true --storage-opt dm.use_deferred_deletion=true --bip=10.120.138.1/23 --ip-masq=true --mtu=1472

    11月 17 17:36:16 centos7 systemd[1]: Starting Docker Application Container Engine...
    11月 17 17:36:16 centos7 docker-current[22540]: time="2016-11-17T17:36:16.419642040+08:00" level=info msg="Graph migration to content-addressability took 0.00 seconds"
    11月 17 17:36:16 centos7 docker-current[22540]: time="2016-11-17T17:36:16.434601879+08:00" level=info msg="Firewalld running: false"
    11月 17 17:36:16 centos7 docker-current[22540]: time="2016-11-17T17:36:16.573898188+08:00" level=info msg="Loading containers: start."
    11月 17 17:36:16 centos7 docker-current[22540]: time="2016-11-17T17:36:16.573995225+08:00" level=info msg="Loading containers: done."
    11月 17 17:36:16 centos7 docker-current[22540]: time="2016-11-17T17:36:16.574014427+08:00" level=info msg="Daemon has completed initialization"
    11月 17 17:36:16 centos7 docker-current[22540]: time="2016-11-17T17:36:16.574038287+08:00" level=info msg="Docker daemon" commit=cb079f6-unsupported execdriver=native-0.2 graphdriver=devicemapper version=1.10.3
    11月 17 17:36:16 centos7 systemd[1]: Started Docker Application Container Engine.
    11月 17 17:36:16 centos7 docker-current[22540]: time="2016-11-17T17:36:16.581244678+08:00" level=info msg="API listen on /var/run/docker.sock"

    [root@centos7 ~]# sudo ip show docker0
    Object "show" is unknown, try "ip help".

    [root@centos7 ~]# sudo ip addr show docker0
    10: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN
        link/ether 02:42:90:66:7e:d4 brd ff:ff:ff:ff:ff:ff
        inet 10.120.138.1/23 scope global docker0
           valid_lft forever preferred_lft forever
