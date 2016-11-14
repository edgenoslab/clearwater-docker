Instruction
-------------

Packages

    [vagrant@localhost ~]$ yum list flannel
    Loaded plugins: fastestmirror
    Loading mirror speeds from cached hostfile
     * base: mirrors.cqu.edu.cn
     * extras: mirrors.163.com
     * updates: mirrors.163.com
    Available Packages
    flannel.x86_64                        0.5.3-9.el7                         extras

* Prerequisites

Firewall

    [tangfx@localhost sysconfig]$ sudo systemctl stop firewalld.service

    [tangfx@localhost sysconfig]$ sudo systemctl disable firewalld.service

* Install from local repo

Start gofileserver

    tangf@DESKTOP-H68OQDV /cygdrive/g/2015-12-19-repository/99-mirror/centos/rsync%3A%2F%2Fmirrors.yun-idc.com%2Fcentos%2F7
    $ gofileserver.exe
    Listening at  :48080

Install package

    [vagrant@localhost ~]$ sudo yum --disablerepo=extras --enablerepo=extras-mirror install flannel
    Loaded plugins: fastestmirror
    Loading mirror speeds from cached hostfile
     * base: mirrors.zju.edu.cn
     * updates: mirrors.zju.edu.cn
    Resolving Dependencies
    --> Running transaction check
    ---> Package flannel.x86_64 0:0.5.3-9.el7 will be installed
    --> Finished Dependency Resolution

    Dependencies Resolved

    ================================================================================
     Package         Arch           Version             Repository             Size
    ================================================================================
    Installing:
     flannel         x86_64         0.5.3-9.el7         extras-mirror         1.7 M

    Transaction Summary
    ================================================================================
    Install  1 Package

    [vagrant@localhost ~]$ sudo yum --disablerepo=\* --enablerepo=c7-media install bridge-utils
    Loaded plugins: fastestmirror
    Loading mirror speeds from cached hostfile
     * c7-media:
    Resolving Dependencies
    --> Running transaction check
    ---> Package bridge-utils.x86_64 0:1.5-9.el7 will be installed
    --> Finished Dependency Resolution

    Dependencies Resolved

    ================================================================================
     Package              Arch           Version             Repository        Size
    ================================================================================
    Installing:
     bridge-utils         x86_64         1.5-9.el7           c7-media          32 k

    Transaction Summary
    ================================================================================
    Install  1 Package

    [vagrant@localhost ~]$ sudo brctl show

* Containers networking

Command *etcdctl*

    [vagrant@localhost ~]$ etcdctl set /coreos.com/network/config '{
    >  "Network": "10.120.0.0/15",
    >  "SubnetLen": 23,
    >  "SubnetMin": "10.120.0.0",
    >  "SubnetMax": "10.121.254.0",
    >  "Backend": {
    >    "Type": "udp"
    >  }
    >}'
    {
      "Network": "10.120.0.0/15",
      "SubnetLen": 23,
      "SubnetMin": "10.120.0.0",
      "SubnetMax": "10.121.254.0",
      "Backend": {
        "Type": "udp"
      }
    }

    [vagrant@localhost ~]$ etcdctl get /coreos.com/network

* Set up 1st node

NIC

    [vagrant@localhost ~]$ ip addr show eth1
    3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
        link/ether 08:00:27:c7:35:fe brd ff:ff:ff:ff:ff:ff
        inet 10.64.33.81/24 brd 10.64.33.255 scope global eth1
           valid_lft forever preferred_lft forever
        inet6 fe80::a00:27ff:fec7:35fe/64 scope link
           valid_lft forever preferred_lft forever

Opts

    [vagrant@localhost ~]$ sudo vi /etc/sysconfig/flanneld
    # Flanneld configuration options

    # etcd url location.  Point this to the server where etcd runs
    # FLANNEL_ETCD="http://127.0.0.1:2379"
    FLANNEL_ETCD="http://10.64.33.81:2379"

    # etcd config key.  This is the configuration key that flannel queries
    # For address range assignment
    # FLANNEL_ETCD_KEY="/atomic.io/network"
    FLANNEL_ETCD_KEY="/coreos.com/network"

    # Any additional options that you want to pass
    #FLANNEL_OPTIONS=""
    FLANNEL_OPTIONS="-iface=eth1"

Service

    [vagrant@localhost ~]$ sudo systemctl edit --full flanneld.service
    [Unit]
    Description=Flanneld overlay address etcd agent
    After=network.target
    After=network-online.target
    Wants=network-online.target
    After=etcd.service
    Before=docker.service

    [Service]
    Type=notify
    EnvironmentFile=/etc/sysconfig/flanneld
    EnvironmentFile=-/etc/sysconfig/docker-network
    ExecStart=/usr/bin/flanneld -etcd-endpoints=${FLANNEL_ETCD} -etcd-prefix=${FLANNEL_ETCD_KEY} $FLANNEL_OPTIONS
    ExecStartPost=/usr/libexec/flannel/mk-docker-opts.sh -k DOCKER_NETWORK_OPTIONS -d /run/flannel/docker
    Restart=on-failure

    [Install]
    WantedBy=multi-user.target
    RequiredBy=docker.service

    [vagrant@localhost ~]$ sudo systemctl enable flanneld.service
    Created symlink from /etc/systemd/system/multi-user.target.wants/flanneld.service to /etc/systemd/system/flanneld.service.
    Created symlink from /etc/systemd/system/docker.service.requires/flanneld.service to /etc/systemd/system/flanneld.service.

    [vagrant@localhost ~]$ sudo systemctl start flanneld.service

Validation

    [vagrant@localhost ~]$ sudo systemctl -l status flanneld.service
    鈼▒ flanneld.service - Flanneld overlay address etcd agent
       Loaded: loaded (/etc/systemd/system/flanneld.service; enabled; vendor preset: disabled)
       Active: active (running) since Sat 2016-11-12 22:39:11 UTC; 7s ago
      Process: 13347 ExecStartPost=/usr/libexec/flannel/mk-docker-opts.sh -k DOCKER_NETWORK_OPTIONS -d /run/flannel/docker (code=exited, status=0/SUCCESS)
     Main PID: 13341 (flanneld)
       CGroup: /system.slice/flanneld.service
               鈹斺攢13341 /usr/bin/flanneld -etcd-endpoints=http://10.64.33.81:2379 -etcd-prefix=/coreos.com/network -iface=eth1

    Nov 12 22:39:11 localhost.localdomain systemd[1]: Starting Flanneld overlay address etcd agent...
    Nov 12 22:39:11 localhost.localdomain flanneld[13341]: I1112 22:39:11.698744 13341 main.go:275] Installing signal handlers
    Nov 12 22:39:11 localhost.localdomain flanneld[13341]: I1112 22:39:11.699475 13341 main.go:188] Using 10.64.33.81 as external interface
    Nov 12 22:39:11 localhost.localdomain flanneld[13341]: I1112 22:39:11.699490 13341 main.go:189] Using 10.64.33.81 as external endpoint
    Nov 12 22:39:11 localhost.localdomain flanneld[13341]: I1112 22:39:11.701864 13341 etcd.go:139] Found lease (10.120.78.0/23) for current IP (10.64.33.81) but not compatible with current config, deleting
    Nov 12 22:39:11 localhost.localdomain flanneld[13341]: I1112 22:39:11.702440 13341 etcd.go:204] Picking subnet in range 10.120.128.0 ... 10.123.128.0
    Nov 12 22:39:11 localhost.localdomain flanneld[13341]: I1112 22:39:11.703392 13341 etcd.go:84] Subnet lease acquired: 10.121.24.0/23
    Nov 12 22:39:11 localhost.localdomain flanneld[13341]: I1112 22:39:11.705016 13341 udp.go:222] Watching for new subnet leases
    Nov 12 22:39:11 localhost.localdomain systemd[1]: Started Flanneld overlay address etcd agent.

    [vagrant@localhost ~]$ cat /run/flannel/subnet.env
    FLANNEL_NETWORK=10.120.0.0/14
    FLANNEL_SUBNET=10.121.24.1/23
    FLANNEL_MTU=1472
    FLANNEL_IPMASQ=false

    [vagrant@localhost ~]$ cat /run/flannel/docker
    DOCKER_OPT_BIP="--bip=10.121.24.1/23"
    DOCKER_OPT_IPMASQ="--ip-masq=true"
    DOCKER_OPT_MTU="--mtu=1472"
    DOCKER_NETWORK_OPTIONS=" --bip=10.121.24.1/23 --ip-masq=true --mtu=1472 "

    [vagrant@localhost ~]$ cat /usr/lib/systemd/system/docker.service.d/flannel.conf
    [Service]
    EnvironmentFile=-/run/flannel/docker

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
           valid_lft 82840sec preferred_lft 82840sec
        inet6 fe80::5054:ff:fe9f:bdfd/64 scope link
           valid_lft forever preferred_lft forever
    3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
        link/ether 08:00:27:c7:35:fe brd ff:ff:ff:ff:ff:ff
        inet 10.64.33.81/24 brd 10.64.33.255 scope global eth1
           valid_lft forever preferred_lft forever
        inet6 fe80::a00:27ff:fec7:35fe/64 scope link
           valid_lft forever preferred_lft forever
    5: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN
        link/ether 02:42:d0:2e:56:3f brd ff:ff:ff:ff:ff:ff
        inet 10.121.24.1/23 scope global docker0
           valid_lft forever preferred_lft forever
    7: flannel0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1472 qdisc pfifo_fast state UNKNOWN qlen 500
        link/none
        inet 10.121.24.0/14 scope global flannel0
           valid_lft forever preferred_lft forever

    [vagrant@localhost ~]$ ip r
    default via 10.0.2.2 dev eth0  proto static  metric 100
    10.0.2.0/24 dev eth0  proto kernel  scope link  src 10.0.2.15  metric 100
    10.64.33.0/24 dev eth1  proto kernel  scope link  src 10.64.33.81
    10.120.0.0/14 dev flannel0  proto kernel  scope link  src 10.121.24.0
    10.121.24.0/23 dev docker0  proto kernel  scope link  src 10.121.24.1
    169.254.0.0/16 dev eth1  scope link  metric 1003

* Command *nmcli*

    [vagrant@localhost ~]$ sudo nmcli d
    DEVICE    TYPE      STATE      CONNECTION
    docker0   bridge    connected  docker0
    eth0      ethernet  connected  Wired connection 1
    flannel0  tun       connected  flannel0
    eth1      ethernet  unmanaged  --
    lo        loopback  unmanaged  --


* Set up 2nd node

NIC

    [tangfx@localhost ~]$ ip a show enp0s8
    3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
        link/ether 08:00:27:24:4e:1c brd ff:ff:ff:ff:ff:ff
        inet 10.64.33.90/24 brd 10.64.33.255 scope global enp0s8
           valid_lft forever preferred_lft forever
        inet6 fe80::a00:27ff:fe24:4e1c/64 scope link
           valid_lft forever preferred_lft forever

Install into fedora23

    [tangfx@localhost ~]$ sudo dnf install flannel
    Last metadata expiration check: 0:00:40 ago on Sun Nov 13 07:16:02 2016.
    Dependencies resolved.
    ================================================================================
     Package          Arch            Version                Repository        Size
    ================================================================================
    Installing:
     flannel          x86_64          0.5.5-3.fc23           updates          2.9 M

    Transaction Summary
    ================================================================================
    Install  1 Package

Opts

    [tangfx@localhost ~]$ sudo vi /etc/sysconfig/flanneld
    # Flanneld configuration options

    # etcd url location.  Point this to the server where etcd runs
    # FLANNEL_ETCD="http://127.0.0.1:2379"
    FLANNEL_ETCD="http://10.64.33.81:2379"

    # etcd config key.  This is the configuration key that flannel queries
    # For address range assignment
    # FLANNEL_ETCD_KEY="/atomic.io/network"
    FLANNEL_ETCD_KEY="/coreos.com/network"

    # Any additional options that you want to pass
    #FLANNEL_OPTIONS=""
    FLANNEL_OPTIONS="-iface=10.64.33.90"

Service

    [tangfx@localhost ~]$ sudo systemctl enable flanneld.service
    Created symlink from /etc/systemd/system/multi-user.target.wants/flanneld.service to /usr/lib/systemd/system/flanneld.service.
    Created symlink from /etc/systemd/system/docker.service.requires/flanneld.service to /usr/lib/systemd/system/flanneld.service.

    [tangfx@localhost sysconfig]$ sudo systemctl start flanneld.service

Validation

    [tangfx@localhost ~]$ cat /run/flannel/docker
    DOCKER_OPT_BIP="--bip=10.120.204.1/23"
    DOCKER_OPT_IPMASQ="--ip-masq=true"
    DOCKER_OPT_MTU="--mtu=1472"
    DOCKER_NETWORK_OPTIONS=" --bip=10.120.204.1/23 --ip-masq=true --mtu=1472 "

    [tangfx@localhost ~]$ cat /run/flannel/subnet.env
    FLANNEL_NETWORK=10.120.0.0/14
    FLANNEL_SUBNET=10.120.204.1/23
    FLANNEL_MTU=1472
    FLANNEL_IPMASQ=false

    [tangfx@localhost ~]$ sudo systemctl -l status flanneld.service
    鈼▒ flanneld.service - Flanneld overlay address etcd agent
       Loaded: loaded (/usr/lib/systemd/system/flanneld.service; enabled; vendor preset: disabled)
       Active: active (running) since Sun 2016-11-13 07:21:23 CST; 21s ago
      Process: 8573 ExecStartPost=/usr/libexec/flannel/mk-docker-opts.sh -k DOCKER_NETWORK_OPTIONS -d /run/flannel/docker (code=exited, status=0/SUCCESS)
     Main PID: 8563 (flanneld)
       CGroup: /system.slice/flanneld.service
               鈹斺攢8563 /usr/bin/flanneld -etcd-endpoints=http://10.64.33.81:2379 -etcd-prefix=/coreos.com/network -iface=10.64.33.90

    Nov 13 07:21:23 localhost.localdomain systemd[1]: Starting Flanneld overlay address etcd agent...
    Nov 13 07:21:23 localhost.localdomain flanneld[8563]: I1113 07:21:23.661160    8563 main.go:275] Installing signal handlers
    Nov 13 07:21:23 localhost.localdomain flanneld[8563]: I1113 07:21:23.661787    8563 main.go:188] Using 10.64.33.90 as external interface
    Nov 13 07:21:23 localhost.localdomain flanneld[8563]: I1113 07:21:23.661843    8563 main.go:189] Using 10.64.33.90 as external endpoint
    Nov 13 07:21:23 localhost.localdomain flanneld[8563]: I1113 07:21:23.667026    8563 etcd.go:204] Picking subnet in range 10.120.128.0 ... 10.123.128.0
    Nov 13 07:21:23 localhost.localdomain flanneld[8563]: I1113 07:21:23.668527    8563 etcd.go:84] Subnet lease acquired: 10.120.204.0/23
    Nov 13 07:21:23 localhost.localdomain flanneld[8563]: I1113 07:21:23.690345    8563 udp.go:222] Watching for new subnet leases
    Nov 13 07:21:23 localhost.localdomain flanneld[8563]: I1113 07:21:23.692843    8563 udp.go:247] Subnet added: 10.121.24.0/23
    Nov 13 07:21:23 localhost.localdomain systemd[1]: Started Flanneld overlay address etcd agent.

    [tangfx@localhost ~]$ ip a show flannel0
    10: flannel0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1472 qdisc fq_codel state UNKNOWN group default qlen 500
        link/none
        inet 10.120.204.0/14 scope global flannel0
           valid_lft forever preferred_lft forever
        inet6 fe80::edd6:165a:c078:f334/64 scope link flags 800
           valid_lft forever preferred_lft forever

    [tangfx@localhost ~]$ ip r
    default via 10.0.2.2 dev enp0s3  proto static  metric 100
    10.0.2.0/24 dev enp0s3  proto kernel  scope link  src 10.0.2.15  metric 100
    10.64.33.0/24 dev enp0s8  proto kernel  scope link  src 10.64.33.90  metric 100
    10.120.0.0/23 dev br-34d5cc1180cb  proto kernel  scope link  src 10.120.0.1
    10.120.0.0/14 dev flannel0  proto kernel  scope link  src 10.120.204.0
    172.17.0.0/16 dev lbr0  proto kernel  scope link  src 172.17.0.1

* Command *nmcli*

    [tangfx@localhost ~]$ sudo nmcli d
    DEVICE           TYPE         STATE      CONNECTION
    br-34d5cc1180cb  bridge       connected  br-34d5cc1180cb
    lbr0             bridge       connected  lbr0
    enp0s3           ethernet     connected  enp0s3
    enp0s8           ethernet     connected  enp0s8
    flannel0         tun          connected  flannel0
    lo               loopback     unmanaged  --
    br0              openvswitch  unmanaged  --
    ovs-system       openvswitch  unmanaged  --
    tun0             openvswitch  unmanaged  --
    vxlan_sys_4789   vxlan        unmanaged  --

    [tangfx@localhost ~]$ sudo nmcli con edit lbr0
    nmcli> set ipv4.addresses
    Enter 'addresses' value: 10.120.204.1/23

    nmcli> save persistent
    Connection 'lbr0' (c0705f51-9954-4943-8361-af31ef6522db) successfully updated.

    nmcli> quit

    [tangfx@localhost ~]$ sudo nmcli con up lbr0
    Connection successfully activated (master waiting for slaves) (D-Bus active path: /org/freedesktop/NetworkManager/ActiveConnection/6)

    [tangfx@localhost ~]$ ip a show lbr0
    4: lbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
        link/ether f2:41:f3:b1:a3:c3 brd ff:ff:ff:ff:ff:ff
        inet 10.120.204.1/23 brd 10.120.205.255 scope global lbr0
           valid_lft forever preferred_lft forever    

* Cluster networking

From 2nd PING 1st

    [tangfx@localhost ~]$ ping -c3 10.121.24.0
    PING 10.121.24.0 (10.121.24.0) 56(84) bytes of data.
    64 bytes from 10.121.24.0: icmp_seq=1 ttl=62 time=0.670 ms
    64 bytes from 10.121.24.0: icmp_seq=2 ttl=62 time=1.07 ms
    64 bytes from 10.121.24.0: icmp_seq=3 ttl=62 time=1.07 ms

    --- 10.121.24.0 ping statistics ---
    3 packets transmitted, 3 received, 0% packet loss, time 2001ms
    rtt min/avg/max/mdev = 0.670/0.938/1.074/0.191 ms

    [tangfx@localhost ~]$ ping -c3 10.121.24.1
    PING 10.121.24.1 (10.121.24.1) 56(84) bytes of data.
    64 bytes from 10.121.24.1: icmp_seq=1 ttl=62 time=0.104 ms
    64 bytes from 10.121.24.1: icmp_seq=2 ttl=62 time=8.45 ms
    64 bytes from 10.121.24.1: icmp_seq=3 ttl=62 time=1.18 ms

    --- 10.121.24.1 ping statistics ---
    3 packets transmitted, 3 received, 0% packet loss, time 2001ms
    rtt min/avg/max/mdev = 0.104/3.250/8.457/3.708 ms

From 1st PING 2nd

    [vagrant@localhost ~]$ ping -c3 10.120.204.1
    PING 10.120.204.1 (10.120.204.1) 56(84) bytes of data.
    64 bytes from 10.120.204.1: icmp_seq=1 ttl=62 time=0.538 ms
    64 bytes from 10.120.204.1: icmp_seq=2 ttl=62 time=1.24 ms
    64 bytes from 10.120.204.1: icmp_seq=3 ttl=62 time=1.10 ms

    --- 10.120.204.1 ping statistics ---
    3 packets transmitted, 3 received, 0% packet loss, time 2002ms
    rtt min/avg/max/mdev = 0.538/0.960/1.240/0.303 ms

    [vagrant@localhost ~]$ ping -c3 10.120.204.0
    PING 10.120.204.0 (10.120.204.0) 56(84) bytes of data.
    64 bytes from 10.120.204.0: icmp_seq=1 ttl=62 time=0.412 ms
    64 bytes from 10.120.204.0: icmp_seq=2 ttl=62 time=1.05 ms
    64 bytes from 10.120.204.0: icmp_seq=3 ttl=62 time=1.09 ms

    --- 10.120.204.0 ping statistics ---
    3 packets transmitted, 3 received, 0% packet loss, time 2001ms
    rtt min/avg/max/mdev = 0.412/0.855/1.098/0.313 ms
