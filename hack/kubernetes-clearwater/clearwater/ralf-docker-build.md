
Content

    [tangfx@localhost homestead-docker]$ mkdir -p ../ralf-docker && cd ../ralf-docker

    [tangfx@localhost ralf-docker]$ vi Dockerfile

    [tangfx@localhost ralf-docker]$ vi Makefile

    [tangfx@localhost ralf]$ make IMG_TAG=1611180614.gitrev-c2da9c9                 
    /usr/bin/docker build --tag=docker.io/tangfeixiong/clearwater-ralf:1611180614.gitrev-c2da9c9 --file=../../../../ralf/Dockerfile.tangfx ../../../../ralf
    Sending build context to Docker daemon 23.55 kB
    Step 1 : FROM docker.io/tangfeixiong/clearwater-base-onbuild:1611180614.gitrev-c2da9c9
    # Executing 2 build triggers...
    Step 1 : EXPOSE 22
     ---> Using cache
    Step 1 : CMD /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
     ---> Using cache
     ---> e16796a8d558
    Step 2 : MAINTAINER tangfeixiong<tangfx128@gmail.com>
     ---> Using cache
     ---> e8f24f33160d
    Step 3 : USER root
     ---> Using cache
     ---> dbc83c55f6a4
    Step 4 : ADD *supervisord.conf /etc/supervisor/conf.d/
     ---> 24121aac3fa7
    Removing intermediate container 9011c403cce5
    Step 5 : RUN apt-get update &&   DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes ralf &&   sed -e 's/\(echo 0 > \/proc\/sys\/kernel\/yama\/ptrace_scope\)/# \0/g' -i /etc/init.d/ralf &&   mv /etc/supervisor/conf.d/ralf.supervisord.conf /etc/supervisor/conf.d/ralf.conf &&   mv /etc/supervisor/conf.d/clearwater-group.supervisord.conf /etc/supervisor/conf.d/clearwater-group.conf
     ---> Running in 84eb2fb090e2
    Ign http://10.64.33.1:48080 binary/ InRelease
    Hit http://10.64.33.1:48080 binary/ Release.gpg
    Hit http://10.64.33.1:48080 binary/ Release
    Ign http://mirrors.aliyun.com trusty InRelease
    Get:1 http://mirrors.aliyun.com trusty-updates InRelease [65.9 kB]
    Get:2 http://mirrors.aliyun.com trusty-security InRelease [65.9 kB]
    Hit http://10.64.33.1:48080 binary/ Packages
    Hit http://mirrors.aliyun.com trusty Release.gpg
    Get:3 http://mirrors.aliyun.com trusty-updates/main Sources [476 kB]
    Get:4 http://mirrors.aliyun.com trusty-updates/restricted Sources [5,921 B]
    Get:5 http://mirrors.aliyun.com trusty-updates/universe Sources [214 kB]
    Get:6 http://mirrors.aliyun.com trusty-updates/main amd64 Packages [1,145 kB]
    Get:7 http://mirrors.aliyun.com trusty-updates/restricted amd64 Packages [20.4 kB]
    Get:8 http://mirrors.aliyun.com trusty-updates/universe amd64 Packages [502 kB]
    Hit http://mirrors.aliyun.com trusty Release
    Get:9 http://mirrors.aliyun.com trusty-security/main Sources [153 kB]
    Get:10 http://mirrors.aliyun.com trusty-security/restricted Sources [4,621 B]
    Get:11 http://mirrors.aliyun.com trusty-security/universe Sources [54.0 kB]
    Get:12 http://mirrors.aliyun.com trusty-security/main amd64 Packages [681 kB]
    Get:13 http://mirrors.aliyun.com trusty-security/restricted amd64 Packages [17.0 kB]
    Get:14 http://mirrors.aliyun.com trusty-security/universe amd64 Packages [188 kB]
    Hit http://mirrors.aliyun.com trusty/main Sources
    Hit http://mirrors.aliyun.com trusty/restricted Sources
    Hit http://mirrors.aliyun.com trusty/universe Sources
    Hit http://mirrors.aliyun.com trusty/main amd64 Packages
    Hit http://mirrors.aliyun.com trusty/restricted amd64 Packages
    Hit http://mirrors.aliyun.com trusty/universe amd64 Packages
    Fetched 3,590 kB in 6s (558 kB/s)
    Reading package lists...
    W: Size of file /var/lib/apt/lists/mirrors.aliyun.com_ubuntu_dists_trusty-updates_main_source_Sources.gz is not what the server reported 475624 475632
    W: Size of file /var/lib/apt/lists/mirrors.aliyun.com_ubuntu_dists_trusty-security_main_source_Sources.gz is not what the server reported 153056 153059
    W: Size of file /var/lib/apt/lists/mirrors.aliyun.com_ubuntu_dists_trusty-security_main_binary-amd64_Packages.gz is not what the server reported 680542 680554
    W: Size of file /var/lib/apt/lists/mirrors.aliyun.com_ubuntu_dists_trusty-security_universe_binary-amd64_Packages.gz is not what the server reported 187712 187715
    Reading package lists...
    Building dependency tree...
    Reading state information...
    The following extra packages will be installed:
      clearwater-log-cleanup clearwater-socket-factory clearwater-tcp-scalability
      libboost-filesystem1.54.0 libboost-regex1.54.0 libboost-system1.54.0
      libevent-2.0-5 libevent-core-2.0-5 libevent-pthreads-2.0-5 libicu52 libpci3
      libperl5.18 libsctp1 libsnmp-base libsnmp30 lksctp-tools ralf-libs
    Suggested packages:
      snmp-mibs-downloader ralf-dbg clearwater-snmp-alarm-agent
    The following NEW packages will be installed:
      clearwater-log-cleanup clearwater-socket-factory clearwater-tcp-scalability
      libboost-filesystem1.54.0 libboost-regex1.54.0 libboost-system1.54.0
      libevent-2.0-5 libevent-core-2.0-5 libevent-pthreads-2.0-5 libicu52 libpci3
      libperl5.18 libsctp1 libsnmp-base libsnmp30 lksctp-tools ralf ralf-libs
    0 upgraded, 18 newly installed, 0 to remove and 9 not upgraded.
    Need to get 9,421 kB of archives.
    After this operation, 38.5 MB of additional disk space will be used.
    Get:1 http://10.64.33.1:48080/mirror/repo.cw-ngv.com/stable/ binary/ libsnmp-base 5.7.2~dfsg-clearwater4 [224 kB]
    Get:2 http://10.64.33.1:48080/mirror/repo.cw-ngv.com/stable/ binary/ libsnmp30 5.7.2~dfsg-clearwater4 [811 kB]
    Get:3 http://10.64.33.1:48080/mirror/repo.cw-ngv.com/stable/ binary/ clearwater-log-cleanup 1.0-161102.114310 [13.3 kB]
    Get:4 http://10.64.33.1:48080/mirror/repo.cw-ngv.com/stable/ binary/ clearwater-socket-factory 1.0-161102.114310 [32.0 kB]
    Get:5 http://10.64.33.1:48080/mirror/repo.cw-ngv.com/stable/ binary/ clearwater-tcp-scalability 1.0-161102.114310 [14.6 kB]
    Get:6 http://10.64.33.1:48080/mirror/repo.cw-ngv.com/stable/ binary/ ralf-libs 1.0-161104.122049 [656 kB]
    Get:7 http://10.64.33.1:48080/mirror/repo.cw-ngv.com/stable/ binary/ ralf 1.0-161104.122049 [314 kB]
    Get:8 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libpci3 amd64 1:3.2.1-1ubuntu5.1 [26.3 kB]
    Get:9 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libboost-system1.54.0 amd64 1.54.0-4ubuntu3.1 [10.1 kB]
    Get:10 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libboost-filesystem1.54.0 amd64 1.54.0-4ubuntu3.1 [34.2 kB]
    Get:11 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libicu52 amd64 52.1-3ubuntu0.4 [6,752 kB]
    Get:12 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libboost-regex1.54.0 amd64 1.54.0-4ubuntu3.1 [261 kB]
    Get:13 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libevent-2.0-5 amd64 2.0.21-stable-1ubuntu1.14.04.1 [126 kB]
    Get:14 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libevent-core-2.0-5 amd64 2.0.21-stable-1ubuntu1.14.04.1 [78.3 kB]
    Get:15 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libevent-pthreads-2.0-5 amd64 2.0.21-stable-1ubuntu1.14.04.1 [6,126 B]
    Get:16 http://mirrors.aliyun.com/ubuntu/ trusty/main libsctp1 amd64 1.0.15+dfsg-1 [9,226 B]
    Get:17 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libperl5.18 amd64 5.18.2-2ubuntu1.1 [1,332 B]
    Get:18 http://mirrors.aliyun.com/ubuntu/ trusty/main lksctp-tools amd64 1.0.15+dfsg-1 [51.3 kB]
    Fetched 9,421 kB in 12s (741 kB/s)
    Selecting previously unselected package libpci3:amd64.
    (Reading database ... 24489 files and directories currently installed.)
    Preparing to unpack .../libpci3_1%3a3.2.1-1ubuntu5.1_amd64.deb ...
    Unpacking libpci3:amd64 (1:3.2.1-1ubuntu5.1) ...
    Selecting previously unselected package libboost-system1.54.0:amd64.
    Preparing to unpack .../libboost-system1.54.0_1.54.0-4ubuntu3.1_amd64.deb ...
    Unpacking libboost-system1.54.0:amd64 (1.54.0-4ubuntu3.1) ...
    Selecting previously unselected package libboost-filesystem1.54.0:amd64.
    Preparing to unpack .../libboost-filesystem1.54.0_1.54.0-4ubuntu3.1_amd64.deb ...
    Unpacking libboost-filesystem1.54.0:amd64 (1.54.0-4ubuntu3.1) ...
    Selecting previously unselected package libicu52:amd64.
    Preparing to unpack .../libicu52_52.1-3ubuntu0.4_amd64.deb ...
    Unpacking libicu52:amd64 (52.1-3ubuntu0.4) ...
    Selecting previously unselected package libboost-regex1.54.0:amd64.
    Preparing to unpack .../libboost-regex1.54.0_1.54.0-4ubuntu3.1_amd64.deb ...
    Unpacking libboost-regex1.54.0:amd64 (1.54.0-4ubuntu3.1) ...
    Selecting previously unselected package libevent-2.0-5:amd64.
    Preparing to unpack .../libevent-2.0-5_2.0.21-stable-1ubuntu1.14.04.1_amd64.deb ...
    Unpacking libevent-2.0-5:amd64 (2.0.21-stable-1ubuntu1.14.04.1) ...
    Selecting previously unselected package libevent-core-2.0-5:amd64.
    Preparing to unpack .../libevent-core-2.0-5_2.0.21-stable-1ubuntu1.14.04.1_amd64.deb ...
    Unpacking libevent-core-2.0-5:amd64 (2.0.21-stable-1ubuntu1.14.04.1) ...
    Selecting previously unselected package libevent-pthreads-2.0-5:amd64.
    Preparing to unpack .../libevent-pthreads-2.0-5_2.0.21-stable-1ubuntu1.14.04.1_amd64.deb ...
    Unpacking libevent-pthreads-2.0-5:amd64 (2.0.21-stable-1ubuntu1.14.04.1) ...
    Selecting previously unselected package libsctp1:amd64.
    Preparing to unpack .../libsctp1_1.0.15+dfsg-1_amd64.deb ...
    Unpacking libsctp1:amd64 (1.0.15+dfsg-1) ...
    Selecting previously unselected package libperl5.18.
    Preparing to unpack .../libperl5.18_5.18.2-2ubuntu1.1_amd64.deb ...
    Unpacking libperl5.18 (5.18.2-2ubuntu1.1) ...
    Selecting previously unselected package libsnmp-base.
    Preparing to unpack .../libsnmp-base_5.7.2~dfsg-clearwater4_all.deb ...
    Unpacking libsnmp-base (5.7.2~dfsg-clearwater4) ...
    Selecting previously unselected package libsnmp30:amd64.
    Preparing to unpack .../libsnmp30_5.7.2~dfsg-clearwater4_amd64.deb ...
    Unpacking libsnmp30:amd64 (5.7.2~dfsg-clearwater4) ...
    Selecting previously unselected package clearwater-log-cleanup.
    Preparing to unpack .../clearwater-log-cleanup_1.0-161102.114310_all.deb ...
    Unpacking clearwater-log-cleanup (1.0-161102.114310) ...
    Selecting previously unselected package clearwater-socket-factory.
    Preparing to unpack .../clearwater-socket-factory_1.0-161102.114310_amd64.deb ...
    Unpacking clearwater-socket-factory (1.0-161102.114310) ...
    Selecting previously unselected package clearwater-tcp-scalability.
    Preparing to unpack .../clearwater-tcp-scalability_1.0-161102.114310_all.deb ...
    Unpacking clearwater-tcp-scalability (1.0-161102.114310) ...
    Selecting previously unselected package lksctp-tools.
    Preparing to unpack .../lksctp-tools_1.0.15+dfsg-1_amd64.deb ...
    Unpacking lksctp-tools (1.0.15+dfsg-1) ...
    Selecting previously unselected package ralf-libs.
    Preparing to unpack .../ralf-libs_1.0-161104.122049_amd64.deb ...
    Unpacking ralf-libs (1.0-161104.122049) ...
    Selecting previously unselected package ralf.
    Preparing to unpack .../ralf_1.0-161104.122049_amd64.deb ...
    Unpacking ralf (1.0-161104.122049) ...
    Processing triggers for ureadahead (0.100.0-16) ...
    Setting up libpci3:amd64 (1:3.2.1-1ubuntu5.1) ...
    Setting up libboost-system1.54.0:amd64 (1.54.0-4ubuntu3.1) ...
    Setting up libboost-filesystem1.54.0:amd64 (1.54.0-4ubuntu3.1) ...
    Setting up libicu52:amd64 (52.1-3ubuntu0.4) ...
    Setting up libboost-regex1.54.0:amd64 (1.54.0-4ubuntu3.1) ...
    Setting up libevent-2.0-5:amd64 (2.0.21-stable-1ubuntu1.14.04.1) ...
    Setting up libevent-core-2.0-5:amd64 (2.0.21-stable-1ubuntu1.14.04.1) ...
    Setting up libevent-pthreads-2.0-5:amd64 (2.0.21-stable-1ubuntu1.14.04.1) ...
    Setting up libsctp1:amd64 (1.0.15+dfsg-1) ...
    Setting up libperl5.18 (5.18.2-2ubuntu1.1) ...
    Setting up libsnmp-base (5.7.2~dfsg-clearwater4) ...
    Setting up libsnmp30:amd64 (5.7.2~dfsg-clearwater4) ...
    Setting up clearwater-log-cleanup (1.0-161102.114310) ...
    Setting up clearwater-socket-factory (1.0-161102.114310) ...
    Setting up clearwater-tcp-scalability (1.0-161102.114310) ...
    Setting up lksctp-tools (1.0.15+dfsg-1) ...
    Setting up ralf-libs (1.0-161104.122049) ...
    Processing triggers for ureadahead (0.100.0-16) ...
    Setting up ralf (1.0-161104.122049) ...
     * Restarting clearwater-infrastructure clearwater-infrastructure
    mv: cannot move 鈥▒/tmp/hosts.305鈥▒ to 鈥▒/etc/hosts鈥▒: Device or resource busy
     * Restarting DNS forwarder and DHCP server dnsmasq

    dnsmasq: setting capabilities failed: Operation not permitted
       ...fail!
    hostname: you must be root to change the host name
    mv: cannot move 鈥▒/tmp/hosts.326鈥▒ to 鈥▒/etc/hosts鈥▒: Device or resource busy
    Configuring monit for only localhost access
    ** Note: Please use the --sec-param instead of --bits
    Generating a 1024 bit RSA private key...
    Generating a self signed certificate...
    X.509 Certificate Information:
            Version: 3
            Serial Number (hex): 582e4e22
            Validity:
                    Not Before: Fri Nov 18 00:41:06 UTC 2016
                    Not After: Mon Nov 16 00:41:06 UTC 2026
            Subject: CN=10.120.160.2
            Subject Public Key Algorithm: RSA
            Certificate Security Level: Weak
                    Modulus (bits 1024):
                            00:db:17:49:39:b6:71:54:72:21:8d:fd:1e:83:1b:70
                            49:85:9c:48:7d:b4:24:0a:09:58:2b:e4:b6:3f:9b:8a
                            db:b9:ea:3f:7c:77:d7:38:92:9d:46:31:7d:d7:91:c6
                            57:d0:05:e1:82:fe:df:f6:c6:24:12:ee:73:9b:4d:8e
                            41:97:80:fd:34:20:b2:09:29:a8:31:61:b3:e2:76:a9
                            d2:9e:27:18:c3:8c:4f:62:57:10:f8:60:48:27:f7:0e
                            07:24:9e:37:1f:94:57:46:34:95:48:d7:6f:40:2e:eb
                            a4:3f:69:e7:bd:57:af:4a:3c:0b:97:86:3b:44:40:b5
                            0d
                    Exponent (bits 24):
                            01:00:01
            Extensions:
                    Basic Constraints (critical):
                            Certificate Authority (CA): FALSE
                    Subject Key Identifier (not critical):
                            f4c5e10b23a65ece1c8e884e6ab31d982c601ee9
    Other Information:
            Public Key Id:
                    f4c5e10b23a65ece1c8e884e6ab31d982c601ee9



    Signing certificate...
       ...done.
    Processing triggers for libc-bin (2.19-0ubuntu6.9) ...
    Processing triggers for ureadahead (0.100.0-16) ...
     ---> a86617a0752b
    Removing intermediate container 84eb2fb090e2
    Step 6 : ADD plugins/* /usr/share/clearwater/clearwater-cluster-manager/plugins/
     ---> e9d9376ca31e
    Removing intermediate container 345caf7ca321
    Step 7 : ADD reload_memcached_users /usr/share/clearwater/bin/reload_memcached_users
     ---> 01b340857f6d
    Removing intermediate container a4cde614b5cd
    Step 8 : EXPOSE 10888
     ---> Running in 530c6baf530c
     ---> a7181ba36557
    Removing intermediate container 530c6baf530c
    Successfully built a7181ba36557
