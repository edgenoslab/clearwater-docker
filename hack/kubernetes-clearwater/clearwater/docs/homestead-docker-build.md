
Content

    [tangfx@localhost homer-docker]$ mkdir -p ../homestead-docker && cd ../homestead-docker

    [tangfx@localhost homestead-docker]$ vi Dockerfile

    [tangfx@localhost homestead-docker]$ vi Makefile

    [tangfx@localhost homestead-docker]$ make IMG_TAG=1611180614.gitrev-c2da9c9            
    /usr/bin/docker build --tag=docker.io/tangfeixiong/clearwater-homestead:1611180614.gitrev-c2da9c9 --file=../../../../homestead/Dockerfile.tangfx ../../../../homestead
    Sending build context to Docker daemon 8.192 kB
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
     ---> f4beb208d7fe
    Removing intermediate container 7737f2f027a7
    Step 5 : RUN apt-get update &&   DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes homestead homestead-prov clearwater-prov-tools &&   sed -e 's/\(echo 0 > \/proc\/sys\/kernel\/yama\/ptrace_scope\)/# \1/g' -i /etc/init.d/homestead &&   mv /etc/supervisor/conf.d/homestead.supervisord.conf /etc/supervisor/conf.d/homestead.conf &&   mv /etc/supervisor/conf.d/homestead-prov.supervisord.conf /etc/supervisor/conf.d/homestead-prov.conf &&   mv /etc/supervisor/conf.d/nginx.supervisord.conf /etc/supervisor/conf.d/nginx.conf &&   mv /etc/supervisor/conf.d/clearwater-group.supervisord.conf /etc/supervisor/conf.d/clearwater-group.conf
     ---> Running in 04d75fd05f12
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
    Fetched 3,590 kB in 6s (575 kB/s)
    Reading package lists...
    W: Size of file /var/lib/apt/lists/mirrors.aliyun.com_ubuntu_dists_trusty-updates_universe_binary-amd64_Packages.gz is not what the server reported 501609 501619
    W: Size of file /var/lib/apt/lists/mirrors.aliyun.com_ubuntu_dists_trusty-security_main_source_Sources.gz is not what the server reported 153056 153059
    W: Size of file /var/lib/apt/lists/mirrors.aliyun.com_ubuntu_dists_trusty-security_main_binary-amd64_Packages.gz is not what the server reported 680542 680554
    W: Size of file /var/lib/apt/lists/mirrors.aliyun.com_ubuntu_dists_trusty-security_universe_binary-amd64_Packages.gz is not what the server reported 187712 187715
    Reading package lists...
    Building dependency tree...
    Reading state information...
    The following extra packages will be installed:
      clearwater-log-cleanup clearwater-nginx clearwater-socket-factory
      clearwater-tcp-scalability crest fontconfig-config fonts-dejavu-core
      geoip-database homestead-libs libboost-filesystem1.54.0 libboost-regex1.54.0
      libboost-system1.54.0 libcurl3-gnutls libevent-2.0-5 libevent-core-2.0-5
      libevent-pthreads-2.0-5 libfontconfig1 libfreetype6 libgd3 libgeoip1
      libicu52 libjbig0 libjpeg-turbo8 libjpeg8 libpci3 libperl5.18 libsctp1
      libsnmp-base libsnmp30 libtiff5 libvpx1 libxml2 libxml2-dev libxpm4
      libxslt1-dev libxslt1.1 lksctp-tools nginx nginx-common nginx-core
      python-zmq sgml-base xml-core
    Suggested packages:
      clearwater-snmp-handler-alarm clearwater-logging clearwater-snmpd
      clearwater-secure-connections homestead-dbg clearwater-snmp-alarm-agent
      libgd-tools geoip-bin snmp-mibs-downloader pkg-config fcgiwrap nginx-doc
      sgml-base-doc debhelper
    The following NEW packages will be installed:
      clearwater-log-cleanup clearwater-nginx clearwater-prov-tools
      clearwater-socket-factory clearwater-tcp-scalability crest fontconfig-config
      fonts-dejavu-core geoip-database homestead homestead-libs homestead-prov
      libboost-filesystem1.54.0 libboost-regex1.54.0 libboost-system1.54.0
      libcurl3-gnutls libevent-2.0-5 libevent-core-2.0-5 libevent-pthreads-2.0-5
      libfontconfig1 libfreetype6 libgd3 libgeoip1 libicu52 libjbig0
      libjpeg-turbo8 libjpeg8 libpci3 libperl5.18 libsctp1 libsnmp-base libsnmp30
      libtiff5 libvpx1 libxml2 libxml2-dev libxpm4 libxslt1-dev libxslt1.1
      lksctp-tools nginx nginx-common nginx-core python-zmq sgml-base xml-core
    0 upgraded, 46 newly installed, 0 to remove and 9 not upgraded.
    Need to get 29.2 MB of archives.
    After this operation, 111 MB of additional disk space will be used.
    Get:1 http://10.64.33.1:48080/mirror/repo.cw-ngv.com/stable/ binary/ libsnmp-base 5.7.2~dfsg-clearwater4 [224 kB]
    Get:2 http://10.64.33.1:48080/mirror/repo.cw-ngv.com/stable/ binary/ libsnmp30 5.7.2~dfsg-clearwater4 [811 kB]
    Get:3 http://10.64.33.1:48080/mirror/repo.cw-ngv.com/stable/ binary/ clearwater-log-cleanup 1.0-161102.114310 [13.3 kB]
    Get:4 http://10.64.33.1:48080/mirror/repo.cw-ngv.com/stable/ binary/ clearwater-nginx 1.0-161028.000011 [19.7 kB]
    Get:5 http://10.64.33.1:48080/mirror/repo.cw-ngv.com/stable/ binary/ clearwater-prov-tools 1.0-161104.121210 [3,779 kB]
    Get:6 http://10.64.33.1:48080/mirror/repo.cw-ngv.com/stable/ binary/ clearwater-socket-factory 1.0-161102.114310 [32.0 kB]
    Get:7 http://10.64.33.1:48080/mirror/repo.cw-ngv.com/stable/ binary/ clearwater-tcp-scalability 1.0-161102.114310 [14.6 kB]
    Get:8 http://10.64.33.1:48080/mirror/repo.cw-ngv.com/stable/ binary/ crest 1.0-161104.120822 [9,294 kB]
    Get:9 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libcurl3-gnutls amd64 7.35.0-1ubuntu2.10 [166 kB]
    Get:10 http://10.64.33.1:48080/mirror/repo.cw-ngv.com/stable/ binary/ homestead-libs 1.0-161104.122821 [1,006 kB]
    Get:11 http://10.64.33.1:48080/mirror/repo.cw-ngv.com/stable/ binary/ homestead 1.0-161104.122821 [380 kB]
    Get:12 http://10.64.33.1:48080/mirror/repo.cw-ngv.com/stable/ binary/ homestead-prov 1.0-161104.120822 [74.5 kB]
    Get:13 http://mirrors.aliyun.com/ubuntu/ trusty/main libgeoip1 amd64 1.6.0-1 [71.0 kB]
    Get:14 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libpci3 amd64 1:3.2.1-1ubuntu5.1 [26.3 kB]
    Get:15 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libxml2 amd64 2.9.1+dfsg1-3ubuntu4.8 [573 kB]
    Get:16 http://mirrors.aliyun.com/ubuntu/ trusty/main sgml-base all 1.26+nmu4ubuntu1 [12.5 kB]
    Get:17 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libboost-system1.54.0 amd64 1.54.0-4ubuntu3.1 [10.1 kB]
    Get:18 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libboost-filesystem1.54.0 amd64 1.54.0-4ubuntu3.1 [34.2 kB]
    Get:19 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libicu52 amd64 52.1-3ubuntu0.4 [6,752 kB]
    Get:20 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libboost-regex1.54.0 amd64 1.54.0-4ubuntu3.1 [261 kB]
    Get:21 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libevent-2.0-5 amd64 2.0.21-stable-1ubuntu1.14.04.1 [126 kB]
    Get:22 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libevent-core-2.0-5 amd64 2.0.21-stable-1ubuntu1.14.04.1 [78.3 kB]
    Get:23 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libevent-pthreads-2.0-5 amd64 2.0.21-stable-1ubuntu1.14.04.1 [6,126 B]
    Get:24 http://mirrors.aliyun.com/ubuntu/ trusty/main fonts-dejavu-core all 2.34-1ubuntu1 [1,024 kB]
    Get:25 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main fontconfig-config all 2.11.0-0ubuntu4.2 [47.4 kB]
    Get:26 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libfreetype6 amd64 2.5.2-1ubuntu2.5 [304 kB]
    Get:27 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libfontconfig1 amd64 2.11.0-0ubuntu4.2 [123 kB]
    Get:28 http://mirrors.aliyun.com/ubuntu/ trusty/main libjpeg-turbo8 amd64 1.3.0-0ubuntu2 [104 kB]
    Get:29 http://mirrors.aliyun.com/ubuntu/ trusty/main libjpeg8 amd64 8c-2ubuntu8 [2,194 B]
    Get:30 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libjbig0 amd64 2.0-2ubuntu4.1 [26.1 kB]
    Get:31 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libtiff5 amd64 4.0.3-7ubuntu0.4 [143 kB]
    Get:32 http://mirrors.aliyun.com/ubuntu/ trusty/main libvpx1 amd64 1.3.0-2 [556 kB]
    Get:33 http://mirrors.aliyun.com/ubuntu/ trusty/main libxpm4 amd64 1:3.5.10-1 [38.3 kB]
    Get:34 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libgd3 amd64 2.1.0-3ubuntu0.5 [122 kB]
    Get:35 http://mirrors.aliyun.com/ubuntu/ trusty/main libsctp1 amd64 1.0.15+dfsg-1 [9,226 B]
    Get:36 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libperl5.18 amd64 5.18.2-2ubuntu1.1 [1,332 B]
    Get:37 http://mirrors.aliyun.com/ubuntu/ trusty/main libxslt1.1 amd64 1.1.28-2build1 [145 kB]
    Get:38 http://mirrors.aliyun.com/ubuntu/ trusty/main geoip-database all 20140313-1 [1,196 kB]
    Get:39 http://mirrors.aliyun.com/ubuntu/ trusty/main xml-core all 0.13+nmu2 [23.3 kB]
    Get:40 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main nginx-common all 1.4.6-1ubuntu3.7 [19.0 kB]
    Get:41 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main nginx-core amd64 1.4.6-1ubuntu3.7 [325 kB]
    Get:42 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main nginx all 1.4.6-1ubuntu3.7 [5,352 B]
    Get:43 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libxml2-dev amd64 2.9.1+dfsg1-3ubuntu4.8 [631 kB]
    Get:44 http://mirrors.aliyun.com/ubuntu/ trusty/main libxslt1-dev amd64 1.1.28-2build1 [407 kB]
    Get:45 http://mirrors.aliyun.com/ubuntu/ trusty/universe python-zmq amd64 14.0.1-1build2 [175 kB]
    Get:46 http://mirrors.aliyun.com/ubuntu/ trusty/main lksctp-tools amd64 1.0.15+dfsg-1 [51.3 kB]
    Extracting templates from packages: 100%
    Preconfiguring packages ...
    Fetched 29.2 MB in 13s (2,220 kB/s)
    Selecting previously unselected package libcurl3-gnutls:amd64.
    (Reading database ... 24489 files and directories currently installed.)
    Preparing to unpack .../libcurl3-gnutls_7.35.0-1ubuntu2.10_amd64.deb ...
    Unpacking libcurl3-gnutls:amd64 (7.35.0-1ubuntu2.10) ...
    Selecting previously unselected package libgeoip1:amd64.
    Preparing to unpack .../libgeoip1_1.6.0-1_amd64.deb ...
    Unpacking libgeoip1:amd64 (1.6.0-1) ...
    Selecting previously unselected package libpci3:amd64.
    Preparing to unpack .../libpci3_1%3a3.2.1-1ubuntu5.1_amd64.deb ...
    Unpacking libpci3:amd64 (1:3.2.1-1ubuntu5.1) ...
    Selecting previously unselected package libxml2:amd64.
    Preparing to unpack .../libxml2_2.9.1+dfsg1-3ubuntu4.8_amd64.deb ...
    Unpacking libxml2:amd64 (2.9.1+dfsg1-3ubuntu4.8) ...
    Selecting previously unselected package sgml-base.
    Preparing to unpack .../sgml-base_1.26+nmu4ubuntu1_all.deb ...
    Unpacking sgml-base (1.26+nmu4ubuntu1) ...
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
    Selecting previously unselected package fonts-dejavu-core.
    Preparing to unpack .../fonts-dejavu-core_2.34-1ubuntu1_all.deb ...
    Unpacking fonts-dejavu-core (2.34-1ubuntu1) ...
    Selecting previously unselected package fontconfig-config.
    Preparing to unpack .../fontconfig-config_2.11.0-0ubuntu4.2_all.deb ...
    Unpacking fontconfig-config (2.11.0-0ubuntu4.2) ...
    Selecting previously unselected package libfreetype6:amd64.
    Preparing to unpack .../libfreetype6_2.5.2-1ubuntu2.5_amd64.deb ...
    Unpacking libfreetype6:amd64 (2.5.2-1ubuntu2.5) ...
    Selecting previously unselected package libfontconfig1:amd64.
    Preparing to unpack .../libfontconfig1_2.11.0-0ubuntu4.2_amd64.deb ...
    Unpacking libfontconfig1:amd64 (2.11.0-0ubuntu4.2) ...
    Selecting previously unselected package libjpeg-turbo8:amd64.
    Preparing to unpack .../libjpeg-turbo8_1.3.0-0ubuntu2_amd64.deb ...
    Unpacking libjpeg-turbo8:amd64 (1.3.0-0ubuntu2) ...
    Selecting previously unselected package libjpeg8:amd64.
    Preparing to unpack .../libjpeg8_8c-2ubuntu8_amd64.deb ...
    Unpacking libjpeg8:amd64 (8c-2ubuntu8) ...
    Selecting previously unselected package libjbig0:amd64.
    Preparing to unpack .../libjbig0_2.0-2ubuntu4.1_amd64.deb ...
    Unpacking libjbig0:amd64 (2.0-2ubuntu4.1) ...
    Selecting previously unselected package libtiff5:amd64.
    Preparing to unpack .../libtiff5_4.0.3-7ubuntu0.4_amd64.deb ...
    Unpacking libtiff5:amd64 (4.0.3-7ubuntu0.4) ...
    Selecting previously unselected package libvpx1:amd64.
    Preparing to unpack .../libvpx1_1.3.0-2_amd64.deb ...
    Unpacking libvpx1:amd64 (1.3.0-2) ...
    Selecting previously unselected package libxpm4:amd64.
    Preparing to unpack .../libxpm4_1%3a3.5.10-1_amd64.deb ...
    Unpacking libxpm4:amd64 (1:3.5.10-1) ...
    Selecting previously unselected package libgd3:amd64.
    Preparing to unpack .../libgd3_2.1.0-3ubuntu0.5_amd64.deb ...
    Unpacking libgd3:amd64 (2.1.0-3ubuntu0.5) ...
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
    Selecting previously unselected package libxslt1.1:amd64.
    Preparing to unpack .../libxslt1.1_1.1.28-2build1_amd64.deb ...
    Unpacking libxslt1.1:amd64 (1.1.28-2build1) ...
    Selecting previously unselected package geoip-database.
    Preparing to unpack .../geoip-database_20140313-1_all.deb ...
    Unpacking geoip-database (20140313-1) ...
    Selecting previously unselected package xml-core.
    Preparing to unpack .../xml-core_0.13+nmu2_all.deb ...
    Unpacking xml-core (0.13+nmu2) ...
    Selecting previously unselected package clearwater-log-cleanup.
    Preparing to unpack .../clearwater-log-cleanup_1.0-161102.114310_all.deb ...
    Unpacking clearwater-log-cleanup (1.0-161102.114310) ...
    Selecting previously unselected package nginx-common.
    Preparing to unpack .../nginx-common_1.4.6-1ubuntu3.7_all.deb ...
    Unpacking nginx-common (1.4.6-1ubuntu3.7) ...
    Selecting previously unselected package nginx-core.
    Preparing to unpack .../nginx-core_1.4.6-1ubuntu3.7_amd64.deb ...
    Unpacking nginx-core (1.4.6-1ubuntu3.7) ...
    Selecting previously unselected package nginx.
    Preparing to unpack .../nginx_1.4.6-1ubuntu3.7_all.deb ...
    Unpacking nginx (1.4.6-1ubuntu3.7) ...
    Selecting previously unselected package clearwater-nginx.
    Preparing to unpack .../clearwater-nginx_1.0-161028.000011_all.deb ...
    Unpacking clearwater-nginx (1.0-161028.000011) ...
    Selecting previously unselected package clearwater-prov-tools.
    Preparing to unpack .../clearwater-prov-tools_1.0-161104.121210_amd64.deb ...
    Unpacking clearwater-prov-tools (1.0-161104.121210) ...
    Selecting previously unselected package clearwater-socket-factory.
    Preparing to unpack .../clearwater-socket-factory_1.0-161102.114310_amd64.deb ...
    Unpacking clearwater-socket-factory (1.0-161102.114310) ...
    Selecting previously unselected package clearwater-tcp-scalability.
    Preparing to unpack .../clearwater-tcp-scalability_1.0-161102.114310_all.deb ...
    Unpacking clearwater-tcp-scalability (1.0-161102.114310) ...
    Selecting previously unselected package libxml2-dev:amd64.
    Preparing to unpack .../libxml2-dev_2.9.1+dfsg1-3ubuntu4.8_amd64.deb ...
    Unpacking libxml2-dev:amd64 (2.9.1+dfsg1-3ubuntu4.8) ...
    Selecting previously unselected package libxslt1-dev:amd64.
    Preparing to unpack .../libxslt1-dev_1.1.28-2build1_amd64.deb ...
    Unpacking libxslt1-dev:amd64 (1.1.28-2build1) ...
    Selecting previously unselected package python-zmq.
    Preparing to unpack .../python-zmq_14.0.1-1build2_amd64.deb ...
    Unpacking python-zmq (14.0.1-1build2) ...
    Selecting previously unselected package crest.
    Preparing to unpack .../crest_1.0-161104.120822_amd64.deb ...
    Unpacking crest (1.0-161104.120822) ...
    Selecting previously unselected package homestead-libs.
    Preparing to unpack .../homestead-libs_1.0-161104.122821_amd64.deb ...
    Unpacking homestead-libs (1.0-161104.122821) ...
    Selecting previously unselected package homestead.
    Preparing to unpack .../homestead_1.0-161104.122821_amd64.deb ...
    Unpacking homestead (1.0-161104.122821) ...
    Selecting previously unselected package homestead-prov.
    Preparing to unpack .../homestead-prov_1.0-161104.120822_amd64.deb ...
    Unpacking homestead-prov (1.0-161104.120822) ...
    Selecting previously unselected package lksctp-tools.
    Preparing to unpack .../lksctp-tools_1.0.15+dfsg-1_amd64.deb ...
    Unpacking lksctp-tools (1.0.15+dfsg-1) ...
    Processing triggers for ureadahead (0.100.0-16) ...
    Setting up libcurl3-gnutls:amd64 (7.35.0-1ubuntu2.10) ...
    Setting up libgeoip1:amd64 (1.6.0-1) ...
    Setting up libpci3:amd64 (1:3.2.1-1ubuntu5.1) ...
    Setting up libxml2:amd64 (2.9.1+dfsg1-3ubuntu4.8) ...
    Setting up sgml-base (1.26+nmu4ubuntu1) ...
    Setting up libboost-system1.54.0:amd64 (1.54.0-4ubuntu3.1) ...
    Setting up libboost-filesystem1.54.0:amd64 (1.54.0-4ubuntu3.1) ...
    Setting up libicu52:amd64 (52.1-3ubuntu0.4) ...
    Setting up libboost-regex1.54.0:amd64 (1.54.0-4ubuntu3.1) ...
    Setting up libevent-2.0-5:amd64 (2.0.21-stable-1ubuntu1.14.04.1) ...
    Setting up libevent-core-2.0-5:amd64 (2.0.21-stable-1ubuntu1.14.04.1) ...
    Setting up libevent-pthreads-2.0-5:amd64 (2.0.21-stable-1ubuntu1.14.04.1) ...
    Setting up fonts-dejavu-core (2.34-1ubuntu1) ...
    Setting up fontconfig-config (2.11.0-0ubuntu4.2) ...
    Setting up libfreetype6:amd64 (2.5.2-1ubuntu2.5) ...
    Setting up libfontconfig1:amd64 (2.11.0-0ubuntu4.2) ...
    Setting up libjpeg-turbo8:amd64 (1.3.0-0ubuntu2) ...
    Setting up libjpeg8:amd64 (8c-2ubuntu8) ...
    Setting up libjbig0:amd64 (2.0-2ubuntu4.1) ...
    Setting up libtiff5:amd64 (4.0.3-7ubuntu0.4) ...
    Setting up libvpx1:amd64 (1.3.0-2) ...
    Setting up libxpm4:amd64 (1:3.5.10-1) ...
    Setting up libgd3:amd64 (2.1.0-3ubuntu0.5) ...
    Setting up libsctp1:amd64 (1.0.15+dfsg-1) ...
    Setting up libperl5.18 (5.18.2-2ubuntu1.1) ...
    Setting up libsnmp-base (5.7.2~dfsg-clearwater4) ...
    Setting up libsnmp30:amd64 (5.7.2~dfsg-clearwater4) ...
    Setting up libxslt1.1:amd64 (1.1.28-2build1) ...
    Setting up geoip-database (20140313-1) ...
    Setting up xml-core (0.13+nmu2) ...
    Setting up clearwater-log-cleanup (1.0-161102.114310) ...
    Setting up nginx-common (1.4.6-1ubuntu3.7) ...
    Setting up clearwater-prov-tools (1.0-161104.121210) ...
    Already using interpreter /usr/bin/python
    New python executable in /usr/share/clearwater/clearwater-prov-tools/env/bin/python
    Installing setuptools, pip...done.
    Processing backports.ssl_match_hostname-3.5.0.1-py2.7.egg
    creating /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/backports.ssl_match_hostname-3.5.0.1-py2.7.egg
    Extracting backports.ssl_match_hostname-3.5.0.1-py2.7.egg to /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages
    Adding backports.ssl-match-hostname 3.5.0.1 to easy-install.pth file

    Installed /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/backports.ssl_match_hostname-3.5.0.1-py2.7.egg
    Processing dependencies for backports.ssl-match-hostname==3.5.0.1
    Finished processing dependencies for backports.ssl-match-hostname==3.5.0.1
    Processing backports_abc-0.4-py2.7.egg
    creating /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/backports_abc-0.4-py2.7.egg
    Extracting backports_abc-0.4-py2.7.egg to /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages
    Adding backports-abc 0.4 to easy-install.pth file

    Installed /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/backports_abc-0.4-py2.7.egg
    Processing dependencies for backports-abc==0.4
    Finished processing dependencies for backports-abc==0.4
    Processing certifi-2016.9.26-py2.7.egg
    creating /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/certifi-2016.9.26-py2.7.egg
    Extracting certifi-2016.9.26-py2.7.egg to /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages
    Adding certifi 2016.9.26 to easy-install.pth file

    Installed /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/certifi-2016.9.26-py2.7.egg
    Processing dependencies for certifi==2016.9.26
    Finished processing dependencies for certifi==2016.9.26
    Processing cffi-1.5.2-py2.7-linux-x86_64.egg
    creating /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/cffi-1.5.2-py2.7-linux-x86_64.egg
    Extracting cffi-1.5.2-py2.7-linux-x86_64.egg to /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages
    Adding cffi 1.5.2 to easy-install.pth file

    Installed /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/cffi-1.5.2-py2.7-linux-x86_64.egg
    Processing dependencies for cffi==1.5.2
    Searching for pycparser
    Best match: pycparser 2.17
    Processing pycparser-2.17-py2.7.egg
    creating /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/pycparser-2.17-py2.7.egg
    Extracting pycparser-2.17-py2.7.egg to /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages
    Adding pycparser 2.17 to easy-install.pth file

    Installed /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/pycparser-2.17-py2.7.egg
    Finished processing dependencies for cffi==1.5.2
    Processing clearwater_prov_tools-0.1-py2.7.egg
    creating /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/clearwater_prov_tools-0.1-py2.7.egg
    Extracting clearwater_prov_tools-0.1-py2.7.egg to /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages
    Adding clearwater-prov-tools 0.1 to easy-install.pth file

    Installed /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/clearwater_prov_tools-0.1-py2.7.egg
    Processing dependencies for clearwater-prov-tools==0.1
    Searching for tornado
    Best match: tornado 4.4.2
    Processing tornado-4.4.2-py2.7-linux-x86_64.egg
    creating /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/tornado-4.4.2-py2.7-linux-x86_64.egg
    Extracting tornado-4.4.2-py2.7-linux-x86_64.egg to /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages
    Adding tornado 4.4.2 to easy-install.pth file

    Installed /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/tornado-4.4.2-py2.7-linux-x86_64.egg
    Searching for singledispatch
    Best match: singledispatch 3.4.0.3
    Processing singledispatch-3.4.0.3-py2.7.egg
    creating /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/singledispatch-3.4.0.3-py2.7.egg
    Extracting singledispatch-3.4.0.3-py2.7.egg to /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages
    Adding singledispatch 3.4.0.3 to easy-install.pth file

    Installed /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/singledispatch-3.4.0.3-py2.7.egg
    Searching for six
    Best match: six 1.10.0
    Processing six-1.10.0-py2.7.egg
    creating /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/six-1.10.0-py2.7.egg
    Extracting six-1.10.0-py2.7.egg to /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages
    Adding six 1.10.0 to easy-install.pth file

    Installed /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/six-1.10.0-py2.7.egg
    Finished processing dependencies for clearwater-prov-tools==0.1
    Processing metaswitchcommon-0.1-py2.7-linux-x86_64.egg
    creating /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/metaswitchcommon-0.1-py2.7-linux-x86_64.egg
    Extracting metaswitchcommon-0.1-py2.7-linux-x86_64.egg to /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages
    Adding metaswitchcommon 0.1 to easy-install.pth file

    Installed /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/metaswitchcommon-0.1-py2.7-linux-x86_64.egg
    Processing dependencies for metaswitchcommon==0.1
    Searching for monotonic==0.6
    Best match: monotonic 0.6
    Processing monotonic-0.6-py2.7.egg
    creating /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/monotonic-0.6-py2.7.egg
    Extracting monotonic-0.6-py2.7.egg to /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages
    Adding monotonic 0.6 to easy-install.pth file

    Installed /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/monotonic-0.6-py2.7.egg
    Searching for pyzmq==15.2
    Best match: pyzmq 15.2.0
    Processing pyzmq-15.2.0-py2.7-linux-x86_64.egg
    creating /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg
    Extracting pyzmq-15.2.0-py2.7-linux-x86_64.egg to /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages
      File "/usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg/zmq/asyncio.py", line 79
        "{!r}".format(fileobj)) from None
                                   ^
    SyntaxError: invalid syntax

      File "/usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg/zmq/tests/_test_asyncio.py", line 43
        yield from a.send(b'hi')
                 ^
    SyntaxError: invalid syntax

      File "/usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg/zmq/auth/asyncio.py", line 28
        events = yield from self.__poller.poll()
                          ^
    SyntaxError: invalid syntax

    Adding pyzmq 15.2.0 to easy-install.pth file

    Installed /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg
    Searching for pycrypto==2.6.1
    Best match: pycrypto 2.6.1
    Processing pycrypto-2.6.1-py2.7-linux-x86_64.egg
    creating /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/pycrypto-2.6.1-py2.7-linux-x86_64.egg
    Extracting pycrypto-2.6.1-py2.7-linux-x86_64.egg to /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages
    Adding pycrypto 2.6.1 to easy-install.pth file

    Installed /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/pycrypto-2.6.1-py2.7-linux-x86_64.egg
    Searching for py-bcrypt
    Best match: py-bcrypt 0.4
    Processing py_bcrypt-0.4-py2.7-linux-x86_64.egg
    creating /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/py_bcrypt-0.4-py2.7-linux-x86_64.egg
    Extracting py_bcrypt-0.4-py2.7-linux-x86_64.egg to /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages
    Adding py-bcrypt 0.4 to easy-install.pth file

    Installed /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/py_bcrypt-0.4-py2.7-linux-x86_64.egg
    Finished processing dependencies for metaswitchcommon==0.1
    Processing monotonic-0.6-py2.7.egg
    removing '/usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/monotonic-0.6-py2.7.egg' (and everything under it)
    creating /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/monotonic-0.6-py2.7.egg
    Extracting monotonic-0.6-py2.7.egg to /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages
    monotonic 0.6 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/monotonic-0.6-py2.7.egg
    Processing dependencies for monotonic==0.6
    Finished processing dependencies for monotonic==0.6
    Processing py_bcrypt-0.4-py2.7-linux-x86_64.egg
    removing '/usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/py_bcrypt-0.4-py2.7-linux-x86_64.egg' (and everything under it)
    creating /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/py_bcrypt-0.4-py2.7-linux-x86_64.egg
    Extracting py_bcrypt-0.4-py2.7-linux-x86_64.egg to /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages
    py-bcrypt 0.4 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/py_bcrypt-0.4-py2.7-linux-x86_64.egg
    Processing dependencies for py-bcrypt==0.4
    Finished processing dependencies for py-bcrypt==0.4
    Processing pycparser-2.17-py2.7.egg
    removing '/usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/pycparser-2.17-py2.7.egg' (and everything under it)
    creating /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/pycparser-2.17-py2.7.egg
    Extracting pycparser-2.17-py2.7.egg to /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages
    pycparser 2.17 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/pycparser-2.17-py2.7.egg
    Processing dependencies for pycparser==2.17
    Finished processing dependencies for pycparser==2.17
    Processing pycrypto-2.6.1-py2.7-linux-x86_64.egg
    removing '/usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/pycrypto-2.6.1-py2.7-linux-x86_64.egg' (and everything under it)
    creating /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/pycrypto-2.6.1-py2.7-linux-x86_64.egg
    Extracting pycrypto-2.6.1-py2.7-linux-x86_64.egg to /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages
    pycrypto 2.6.1 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/pycrypto-2.6.1-py2.7-linux-x86_64.egg
    Processing dependencies for pycrypto==2.6.1
    Finished processing dependencies for pycrypto==2.6.1
    Processing pyzmq-15.2.0-py2.7-linux-x86_64.egg
    removing '/usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg' (and everything under it)
    creating /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg
    Extracting pyzmq-15.2.0-py2.7-linux-x86_64.egg to /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages
      File "/usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg/zmq/asyncio.py", line 79
        "{!r}".format(fileobj)) from None
                                   ^
    SyntaxError: invalid syntax

      File "/usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg/zmq/tests/_test_asyncio.py", line 43
        yield from a.send(b'hi')
                 ^
    SyntaxError: invalid syntax

      File "/usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg/zmq/auth/asyncio.py", line 28
        events = yield from self.__poller.poll()
                          ^
    SyntaxError: invalid syntax

    pyzmq 15.2.0 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg
    Processing dependencies for pyzmq==15.2.0
    Finished processing dependencies for pyzmq==15.2.0
    Processing singledispatch-3.4.0.3-py2.7.egg
    removing '/usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/singledispatch-3.4.0.3-py2.7.egg' (and everything under it)
    creating /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/singledispatch-3.4.0.3-py2.7.egg
    Extracting singledispatch-3.4.0.3-py2.7.egg to /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages
    singledispatch 3.4.0.3 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/singledispatch-3.4.0.3-py2.7.egg
    Processing dependencies for singledispatch==3.4.0.3
    Finished processing dependencies for singledispatch==3.4.0.3
    Processing six-1.10.0-py2.7.egg
    removing '/usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/six-1.10.0-py2.7.egg' (and everything under it)
    creating /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/six-1.10.0-py2.7.egg
    Extracting six-1.10.0-py2.7.egg to /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages
    six 1.10.0 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/six-1.10.0-py2.7.egg
    Processing dependencies for six==1.10.0
    Finished processing dependencies for six==1.10.0
    Processing tornado-4.4.2-py2.7-linux-x86_64.egg
    removing '/usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/tornado-4.4.2-py2.7-linux-x86_64.egg' (and everything under it)
    creating /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/tornado-4.4.2-py2.7-linux-x86_64.egg
    Extracting tornado-4.4.2-py2.7-linux-x86_64.egg to /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages
    tornado 4.4.2 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/clearwater-prov-tools/env/lib/python2.7/site-packages/tornado-4.4.2-py2.7-linux-x86_64.egg
    Processing dependencies for tornado==4.4.2
    Finished processing dependencies for tornado==4.4.2
     * Restarting clearwater-infrastructure clearwater-infrastructure
    mv: cannot move 鈥▒/tmp/hosts.726鈥▒ to 鈥▒/etc/hosts鈥▒: Device or resource busy
     * Restarting DNS forwarder and DHCP server dnsmasq

    dnsmasq: setting capabilities failed: Operation not permitted
       ...fail!
    nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
    nginx: configuration file /etc/nginx/nginx.conf test is successful
    ** Note: Please use the --sec-param instead of --bits
    Generating a 1024 bit RSA private key...
    Generating a self signed certificate...
    X.509 Certificate Information:
            Version: 3
            Serial Number (hex): 582e4a7e
            Validity:
                    Not Before: Fri Nov 18 00:25:34 UTC 2016
                    Not After: Mon Nov 16 00:25:34 UTC 2026
            Subject: CN=10.120.160.2
            Subject Public Key Algorithm: RSA
            Certificate Security Level: Weak
                    Modulus (bits 1024):
                            00:d3:7f:03:f7:9c:be:88:e2:fe:c1:08:d4:96:50:fc
                            c9:16:18:1a:ec:52:18:cf:4a:de:a8:9b:34:d6:4b:0e
                            12:33:03:9b:0b:d6:55:91:4b:24:43:a7:66:d9:17:d6
                            25:c5:b8:d7:e7:d9:67:06:4a:85:3e:c8:5d:22:b4:35
                            f5:33:d6:2e:f5:a3:a9:58:fd:30:55:76:20:b4:d8:1e
                            6a:f1:c3:c8:bf:18:d5:7d:19:74:cc:68:2e:85:fc:bf
                            f4:a3:6c:0b:35:d9:3f:61:96:d0:42:36:85:26:76:bf
                            bc:70:fa:f5:02:32:e2:27:3f:ef:cf:8c:da:05:04:06
                            43
                    Exponent (bits 24):
                            01:00:01
            Extensions:
                    Basic Constraints (critical):
                            Certificate Authority (CA): FALSE
                    Subject Key Identifier (not critical):
                            953c7bb7ad808f82213400ea230f423bcaa82709
    Other Information:
            Public Key Id:
                    953c7bb7ad808f82213400ea230f423bcaa82709



    Signing certificate...
    hostname: you must be root to change the host name
    mv: cannot move 鈥▒/tmp/hosts.854鈥▒ to 鈥▒/etc/hosts鈥▒: Device or resource busy
    Configuring monit for only localhost access
       ...done.
    Setting up clearwater-socket-factory (1.0-161102.114310) ...
    Setting up clearwater-tcp-scalability (1.0-161102.114310) ...
    Setting up libxml2-dev:amd64 (2.9.1+dfsg1-3ubuntu4.8) ...
    Setting up libxslt1-dev:amd64 (1.1.28-2build1) ...
    Setting up python-zmq (14.0.1-1build2) ...
    Setting up homestead-libs (1.0-161104.122821) ...
    Setting up lksctp-tools (1.0.15+dfsg-1) ...
    Processing triggers for ureadahead (0.100.0-16) ...
    Setting up nginx-core (1.4.6-1ubuntu3.7) ...
    invoke-rc.d: policy-rc.d denied execution of start.
    Setting up nginx (1.4.6-1ubuntu3.7) ...
    Setting up clearwater-nginx (1.0-161028.000011) ...
    Testing nginx configuration...
    nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
    nginx: configuration file /etc/nginx/nginx.conf test is successful
    Site ping has been enabled. Run /etc/init.d/nginx reload to apply the changes.
    Generating a 2048 bit RSA private key
    .............................+++
    .................................+++
    writing new private key to 'nginx.key'
    -----
    Signature ok
    subject=/C=UK/ST=Unknown state/L=Unknown locality/O=Unknown organization/OU=Unknown organizational unit/CN=unknown.example/emailAddress=Unknown
    Getting Private key
    Adding 'diversion of /etc/nginx/nginx.conf to /etc/nginx/nginx.conf.clearwater-orig by clearwater-nginx'
    Setting up crest (1.0-161104.120822) ...
    Already using interpreter /usr/bin/python
    New python executable in /usr/share/clearwater/crest/env/bin/python
    Installing setuptools, pip...done.
    Processing Twisted-16.5.0-py2.7-linux-x86_64.egg
    Copying Twisted-16.5.0-py2.7-linux-x86_64.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding Twisted 16.5.0 to easy-install.pth file
    Installing trial script to /usr/share/clearwater/crest/env/bin
    Installing conch script to /usr/share/clearwater/crest/env/bin
    Installing ckeygen script to /usr/share/clearwater/crest/env/bin
    Installing twist script to /usr/share/clearwater/crest/env/bin
    Installing pyhtmlizer script to /usr/share/clearwater/crest/env/bin
    Installing mailmail script to /usr/share/clearwater/crest/env/bin
    Installing tkconch script to /usr/share/clearwater/crest/env/bin
    Installing twistd script to /usr/share/clearwater/crest/env/bin
    Installing cftp script to /usr/share/clearwater/crest/env/bin

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/Twisted-16.5.0-py2.7-linux-x86_64.egg
    Processing dependencies for Twisted==16.5.0
    Searching for incremental>=16.10.1
    Best match: incremental 16.10.1
    Processing incremental-16.10.1-py2.7.egg
    Copying incremental-16.10.1-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding incremental 16.10.1 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/incremental-16.10.1-py2.7.egg
    Searching for constantly>=15.1
    Best match: constantly 15.1.0
    Processing constantly-15.1.0-py2.7.egg
    Copying constantly-15.1.0-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding constantly 15.1.0 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/constantly-15.1.0-py2.7.egg
    Searching for zope.interface>=3.6.0
    Best match: zope.interface 4.3.2
    Processing zope.interface-4.3.2-py2.7-linux-x86_64.egg
    Copying zope.interface-4.3.2-py2.7-linux-x86_64.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding zope.interface 4.3.2 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/zope.interface-4.3.2-py2.7-linux-x86_64.egg
    Finished processing dependencies for Twisted==16.5.0
    Processing cffi-1.5.2-py2.7-linux-x86_64.egg
    creating /usr/share/clearwater/crest/env/lib/python2.7/site-packages/cffi-1.5.2-py2.7-linux-x86_64.egg
    Extracting cffi-1.5.2-py2.7-linux-x86_64.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding cffi 1.5.2 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/cffi-1.5.2-py2.7-linux-x86_64.egg
    Processing dependencies for cffi==1.5.2
    Searching for pycparser
    Best match: pycparser 2.17
    Processing pycparser-2.17-py2.7.egg
    Copying pycparser-2.17-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding pycparser 2.17 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/pycparser-2.17-py2.7.egg
    Finished processing dependencies for cffi==1.5.2
    Processing cffi-1.8.3-py2.7-linux-x86_64.egg
    creating /usr/share/clearwater/crest/env/lib/python2.7/site-packages/cffi-1.8.3-py2.7-linux-x86_64.egg
    Extracting cffi-1.8.3-py2.7-linux-x86_64.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Removing cffi 1.5.2 from easy-install.pth file
    Adding cffi 1.8.3 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/cffi-1.8.3-py2.7-linux-x86_64.egg
    Processing dependencies for cffi==1.8.3
    Finished processing dependencies for cffi==1.8.3
    Processing constantly-15.1.0-py2.7.egg
    Removing /usr/share/clearwater/crest/env/lib/python2.7/site-packages/constantly-15.1.0-py2.7.egg
    Copying constantly-15.1.0-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    constantly 15.1.0 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/constantly-15.1.0-py2.7.egg
    Processing dependencies for constantly==15.1.0
    Finished processing dependencies for constantly==15.1.0
    Processing cql-1.4.0-py2.7.egg
    Copying cql-1.4.0-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding cql 1.4.0 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/cql-1.4.0-py2.7.egg
    Processing dependencies for cql==1.4.0
    Searching for thrift
    Best match: thrift 0.9.3
    Processing thrift-0.9.3-py2.7-linux-x86_64.egg
    Copying thrift-0.9.3-py2.7-linux-x86_64.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding thrift 0.9.3 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/thrift-0.9.3-py2.7-linux-x86_64.egg
    Finished processing dependencies for cql==1.4.0
    Processing crest-0.1-py2.7.egg
    creating /usr/share/clearwater/crest/env/lib/python2.7/site-packages/crest-0.1-py2.7.egg
    Extracting crest-0.1-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding crest 0.1 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/crest-0.1-py2.7.egg
    Processing dependencies for crest==0.1
    Searching for monotonic==0.6
    Best match: monotonic 0.6
    Processing monotonic-0.6-py2.7.egg
    Copying monotonic-0.6-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding monotonic 0.6 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/monotonic-0.6-py2.7.egg
    Searching for prctl
    Best match: prctl 1.0.1
    Processing prctl-1.0.1-py2.7-linux-x86_64.egg
    Copying prctl-1.0.1-py2.7-linux-x86_64.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding prctl 1.0.1 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/prctl-1.0.1-py2.7-linux-x86_64.egg
    Searching for pure-sasl
    Best match: pure-sasl 0.3.0
    Processing pure_sasl-0.3.0-py2.7.egg
    Copying pure_sasl-0.3.0-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding pure-sasl 0.3.0 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/pure_sasl-0.3.0-py2.7.egg
    Searching for msgpack-python==0.4.7
    Best match: msgpack-python 0.4.7
    Processing msgpack_python-0.4.7-py2.7-linux-x86_64.egg
    Copying msgpack_python-0.4.7-py2.7-linux-x86_64.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding msgpack-python 0.4.7 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/msgpack_python-0.4.7-py2.7-linux-x86_64.egg
    Searching for lxml
    Best match: lxml 3.6.4
    Processing lxml-3.6.4-py2.7-linux-x86_64.egg
    Copying lxml-3.6.4-py2.7-linux-x86_64.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding lxml 3.6.4 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/lxml-3.6.4-py2.7-linux-x86_64.egg
    Searching for cyclone==1.0
    Best match: cyclone 1.0
    Processing cyclone-1.0-py2.7.egg
    Copying cyclone-1.0-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding cyclone 1.0 to easy-install.pth file
    Installing cyclone script to /usr/share/clearwater/crest/env/bin

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/cyclone-1.0-py2.7.egg
    Searching for py-bcrypt
    Best match: py-bcrypt 0.4
    Processing py_bcrypt-0.4-py2.7-linux-x86_64.egg
    Copying py_bcrypt-0.4-py2.7-linux-x86_64.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding py-bcrypt 0.4 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/py_bcrypt-0.4-py2.7-linux-x86_64.egg
    Searching for pyzmq==15.2
    Best match: pyzmq 15.2.0
    Processing pyzmq-15.2.0-py2.7-linux-x86_64.egg
    Copying pyzmq-15.2.0-py2.7-linux-x86_64.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding pyzmq 15.2.0 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg
    Searching for pyopenssl
    Best match: pyOpenSSL 16.2.0
    Processing pyOpenSSL-16.2.0-py2.7.egg
    Copying pyOpenSSL-16.2.0-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding pyOpenSSL 16.2.0 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/pyOpenSSL-16.2.0-py2.7.egg
    Searching for six>=1.5.2
    Best match: six 1.10.0
    Processing six-1.10.0-py2.7.egg
    Copying six-1.10.0-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding six 1.10.0 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/six-1.10.0-py2.7.egg
    Searching for cryptography>=1.3.4
    Best match: cryptography 1.5.2
    Processing cryptography-1.5.2-py2.7-linux-x86_64.egg
    Copying cryptography-1.5.2-py2.7-linux-x86_64.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding cryptography 1.5.2 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/cryptography-1.5.2-py2.7-linux-x86_64.egg
    Searching for ipaddress
    Best match: ipaddress 1.0.17
    Processing ipaddress-1.0.17-py2.7.egg
    Copying ipaddress-1.0.17-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding ipaddress 1.0.17 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/ipaddress-1.0.17-py2.7.egg
    Searching for enum34
    Best match: enum34 1.1.6
    Processing enum34-1.1.6-py2.7.egg
    Copying enum34-1.1.6-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding enum34 1.1.6 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/enum34-1.1.6-py2.7.egg
    Searching for setuptools>=11.3
    Best match: setuptools 24.0.0
    Processing setuptools-24.0.0-py2.7.egg
    Copying setuptools-24.0.0-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding setuptools 24.0.0 to easy-install.pth file
    Installing easy_install script to /usr/share/clearwater/crest/env/bin
    Installing easy_install-2.7 script to /usr/share/clearwater/crest/env/bin

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/setuptools-24.0.0-py2.7.egg
    Searching for pyasn1>=0.1.8

    Note: Bypassing https://pypi.python.org/packages/source/c/certifi/certifi-2016.2.28.tar.gz#md5=5d672aa766e1f773c75cfeccd02d3650 (disallowed host; see http://bit.ly/1dg9ijs for details).


    Note: Bypassing https://pypi.python.org/packages/source/w/wincertstore/wincertstore-0.2.zip#md5=ae728f2f007185648d0c7a8679b361e2 (disallowed host; see http://bit.ly/1dg9ijs for details).

    Best match: pyasn1 0.1.9
    Processing pyasn1-0.1.9-py2.7.egg
    Copying pyasn1-0.1.9-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding pyasn1 0.1.9 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/pyasn1-0.1.9-py2.7.egg
    Searching for idna>=2.0
    Best match: idna 2.1
    Processing idna-2.1-py2.7.egg
    Copying idna-2.1-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding idna 2.1 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/idna-2.1-py2.7.egg
    Finished processing dependencies for crest==0.1
    Processing cryptography-1.5.2-py2.7-linux-x86_64.egg
    removing '/usr/share/clearwater/crest/env/lib/python2.7/site-packages/cryptography-1.5.2-py2.7-linux-x86_64.egg' (and everything under it)
    Copying cryptography-1.5.2-py2.7-linux-x86_64.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    cryptography 1.5.2 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/cryptography-1.5.2-py2.7-linux-x86_64.egg
    Processing dependencies for cryptography==1.5.2
    Finished processing dependencies for cryptography==1.5.2
    Processing cyclone-1.0-py2.7.egg
    removing '/usr/share/clearwater/crest/env/lib/python2.7/site-packages/cyclone-1.0-py2.7.egg' (and everything under it)
    Copying cyclone-1.0-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    cyclone 1.0 is already the active version in easy-install.pth
    Installing cyclone script to /usr/share/clearwater/crest/env/bin

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/cyclone-1.0-py2.7.egg
    Processing dependencies for cyclone==1.0
    Finished processing dependencies for cyclone==1.0
    Processing enum34-1.1.6-py2.7.egg
    Removing /usr/share/clearwater/crest/env/lib/python2.7/site-packages/enum34-1.1.6-py2.7.egg
    Copying enum34-1.1.6-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    enum34 1.1.6 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/enum34-1.1.6-py2.7.egg
    Processing dependencies for enum34==1.1.6
    Finished processing dependencies for enum34==1.1.6
    Processing idna-2.1-py2.7.egg
    Removing /usr/share/clearwater/crest/env/lib/python2.7/site-packages/idna-2.1-py2.7.egg
    Copying idna-2.1-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    idna 2.1 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/idna-2.1-py2.7.egg
    Processing dependencies for idna==2.1
    Finished processing dependencies for idna==2.1
    Processing incremental-16.10.1-py2.7.egg
    removing '/usr/share/clearwater/crest/env/lib/python2.7/site-packages/incremental-16.10.1-py2.7.egg' (and everything under it)
    Copying incremental-16.10.1-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    incremental 16.10.1 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/incremental-16.10.1-py2.7.egg
    Processing dependencies for incremental==16.10.1
    Finished processing dependencies for incremental==16.10.1
    Processing ipaddress-1.0.17-py2.7.egg
    Removing /usr/share/clearwater/crest/env/lib/python2.7/site-packages/ipaddress-1.0.17-py2.7.egg
    Copying ipaddress-1.0.17-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    ipaddress 1.0.17 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/ipaddress-1.0.17-py2.7.egg
    Processing dependencies for ipaddress==1.0.17
    Finished processing dependencies for ipaddress==1.0.17
    Processing lxml-3.6.4-py2.7-linux-x86_64.egg
    removing '/usr/share/clearwater/crest/env/lib/python2.7/site-packages/lxml-3.6.4-py2.7-linux-x86_64.egg' (and everything under it)
    Copying lxml-3.6.4-py2.7-linux-x86_64.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    lxml 3.6.4 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/lxml-3.6.4-py2.7-linux-x86_64.egg
    Processing dependencies for lxml==3.6.4
    Finished processing dependencies for lxml==3.6.4
    Processing metaswitchcommon-0.1-py2.7-linux-x86_64.egg
    Copying metaswitchcommon-0.1-py2.7-linux-x86_64.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding metaswitchcommon 0.1 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/metaswitchcommon-0.1-py2.7-linux-x86_64.egg
    Processing dependencies for metaswitchcommon==0.1
    Searching for pycrypto==2.6.1
    Best match: pycrypto 2.6.1
    Processing pycrypto-2.6.1-py2.7-linux-x86_64.egg
    Copying pycrypto-2.6.1-py2.7-linux-x86_64.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding pycrypto 2.6.1 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/pycrypto-2.6.1-py2.7-linux-x86_64.egg
    Finished processing dependencies for metaswitchcommon==0.1
    Processing monotonic-0.6-py2.7.egg
    Removing /usr/share/clearwater/crest/env/lib/python2.7/site-packages/monotonic-0.6-py2.7.egg
    Copying monotonic-0.6-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    monotonic 0.6 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/monotonic-0.6-py2.7.egg
    Processing dependencies for monotonic==0.6
    Finished processing dependencies for monotonic==0.6
    Processing msgpack_python-0.4.7-py2.7-linux-x86_64.egg
    Removing /usr/share/clearwater/crest/env/lib/python2.7/site-packages/msgpack_python-0.4.7-py2.7-linux-x86_64.egg
    Copying msgpack_python-0.4.7-py2.7-linux-x86_64.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    msgpack-python 0.4.7 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/msgpack_python-0.4.7-py2.7-linux-x86_64.egg
    Processing dependencies for msgpack-python==0.4.7
    Finished processing dependencies for msgpack-python==0.4.7
    Processing prctl-1.0.1-py2.7-linux-x86_64.egg
    Removing /usr/share/clearwater/crest/env/lib/python2.7/site-packages/prctl-1.0.1-py2.7-linux-x86_64.egg
    Copying prctl-1.0.1-py2.7-linux-x86_64.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    prctl 1.0.1 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/prctl-1.0.1-py2.7-linux-x86_64.egg
    Processing dependencies for prctl==1.0.1
    Finished processing dependencies for prctl==1.0.1
    Processing pure_sasl-0.3.0-py2.7.egg
    Removing /usr/share/clearwater/crest/env/lib/python2.7/site-packages/pure_sasl-0.3.0-py2.7.egg
    Copying pure_sasl-0.3.0-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    pure-sasl 0.3.0 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/pure_sasl-0.3.0-py2.7.egg
    Processing dependencies for pure-sasl==0.3.0
    Finished processing dependencies for pure-sasl==0.3.0
    Processing pyOpenSSL-16.2.0-py2.7.egg
    Removing /usr/share/clearwater/crest/env/lib/python2.7/site-packages/pyOpenSSL-16.2.0-py2.7.egg
    Copying pyOpenSSL-16.2.0-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    pyOpenSSL 16.2.0 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/pyOpenSSL-16.2.0-py2.7.egg
    Processing dependencies for pyOpenSSL==16.2.0
    Finished processing dependencies for pyOpenSSL==16.2.0
    Processing py_bcrypt-0.4-py2.7-linux-x86_64.egg
    Removing /usr/share/clearwater/crest/env/lib/python2.7/site-packages/py_bcrypt-0.4-py2.7-linux-x86_64.egg
    Copying py_bcrypt-0.4-py2.7-linux-x86_64.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    py-bcrypt 0.4 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/py_bcrypt-0.4-py2.7-linux-x86_64.egg
    Processing dependencies for py-bcrypt==0.4
    Finished processing dependencies for py-bcrypt==0.4
    Processing pyasn1-0.1.9-py2.7.egg
    Removing /usr/share/clearwater/crest/env/lib/python2.7/site-packages/pyasn1-0.1.9-py2.7.egg
    Copying pyasn1-0.1.9-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    pyasn1 0.1.9 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/pyasn1-0.1.9-py2.7.egg
    Processing dependencies for pyasn1==0.1.9
    Finished processing dependencies for pyasn1==0.1.9
    Processing pycparser-2.17-py2.7.egg
    removing '/usr/share/clearwater/crest/env/lib/python2.7/site-packages/pycparser-2.17-py2.7.egg' (and everything under it)
    Copying pycparser-2.17-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    pycparser 2.17 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/pycparser-2.17-py2.7.egg
    Processing dependencies for pycparser==2.17
    Finished processing dependencies for pycparser==2.17
    Processing pycrypto-2.6.1-py2.7-linux-x86_64.egg
    Removing /usr/share/clearwater/crest/env/lib/python2.7/site-packages/pycrypto-2.6.1-py2.7-linux-x86_64.egg
    Copying pycrypto-2.6.1-py2.7-linux-x86_64.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    pycrypto 2.6.1 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/pycrypto-2.6.1-py2.7-linux-x86_64.egg
    Processing dependencies for pycrypto==2.6.1
    Finished processing dependencies for pycrypto==2.6.1
    Processing pyzmq-15.2.0-py2.7-linux-x86_64.egg
    removing '/usr/share/clearwater/crest/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg' (and everything under it)
    Copying pyzmq-15.2.0-py2.7-linux-x86_64.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    pyzmq 15.2.0 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg
    Processing dependencies for pyzmq==15.2.0
    Finished processing dependencies for pyzmq==15.2.0
    Processing setuptools-24.0.0-py2.7.egg
    Removing /usr/share/clearwater/crest/env/lib/python2.7/site-packages/setuptools-24.0.0-py2.7.egg
    Copying setuptools-24.0.0-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    setuptools 24.0.0 is already the active version in easy-install.pth
    Installing easy_install script to /usr/share/clearwater/crest/env/bin
    Installing easy_install-2.7 script to /usr/share/clearwater/crest/env/bin

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/setuptools-24.0.0-py2.7.egg
    Processing dependencies for setuptools==24.0.0
    Finished processing dependencies for setuptools==24.0.0
    Processing six-1.10.0-py2.7.egg

    Note: Bypassing https://pypi.python.org/packages/source/c/certifi/certifi-2016.2.28.tar.gz#md5=5d672aa766e1f773c75cfeccd02d3650 (disallowed host; see http://bit.ly/1dg9ijs for details).


    Note: Bypassing https://pypi.python.org/packages/source/w/wincertstore/wincertstore-0.2.zip#md5=ae728f2f007185648d0c7a8679b361e2 (disallowed host; see http://bit.ly/1dg9ijs for details).

    removing '/usr/share/clearwater/crest/env/lib/python2.7/site-packages/six-1.10.0-py2.7.egg' (and everything under it)
    Copying six-1.10.0-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    six 1.10.0 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/six-1.10.0-py2.7.egg
    Processing dependencies for six==1.10.0
    Finished processing dependencies for six==1.10.0
    Processing telephus-1.0.0b1-py2.7.egg
    Copying telephus-1.0.0b1-py2.7.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    Adding telephus 1.0.0b1 to easy-install.pth file

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/telephus-1.0.0b1-py2.7.egg
    Processing dependencies for telephus==1.0.0b1
    Finished processing dependencies for telephus==1.0.0b1
    Processing thrift-0.9.3-py2.7-linux-x86_64.egg
    Removing /usr/share/clearwater/crest/env/lib/python2.7/site-packages/thrift-0.9.3-py2.7-linux-x86_64.egg
    Copying thrift-0.9.3-py2.7-linux-x86_64.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    thrift 0.9.3 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/thrift-0.9.3-py2.7-linux-x86_64.egg
    Processing dependencies for thrift==0.9.3
    Finished processing dependencies for thrift==0.9.3
    Processing zope.interface-4.3.2-py2.7-linux-x86_64.egg
    removing '/usr/share/clearwater/crest/env/lib/python2.7/site-packages/zope.interface-4.3.2-py2.7-linux-x86_64.egg' (and everything under it)
    Copying zope.interface-4.3.2-py2.7-linux-x86_64.egg to /usr/share/clearwater/crest/env/lib/python2.7/site-packages
    zope.interface 4.3.2 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/crest/env/lib/python2.7/site-packages/zope.interface-4.3.2-py2.7-linux-x86_64.egg
    Processing dependencies for zope.interface==4.3.2
    Finished processing dependencies for zope.interface==4.3.2
    Setting up homestead (1.0-161104.122821) ...
     * Restarting clearwater-infrastructure clearwater-infrastructure
    mv: cannot move 鈥▒/tmp/hosts.991鈥▒ to 鈥▒/etc/hosts鈥▒: Device or resource busy
     * Restarting DNS forwarder and DHCP server dnsmasq

    dnsmasq: setting capabilities failed: Operation not permitted
       ...fail!
    hostname: you must be root to change the host name
    mv: cannot move 鈥▒/tmp/hosts.1100鈥▒ to 鈥▒/etc/hosts鈥▒: Device or resource busy
    Configuring monit for only localhost access
       ...done.
    Setting up homestead-prov (1.0-161104.120822) ...
    Creating /usr/share/clearwater/homestead/python/packages/site.py
    Processing homestead_prov-0.1-py2.7.egg
    creating /usr/share/clearwater/homestead/python/packages/homestead_prov-0.1-py2.7.egg
    Extracting homestead_prov-0.1-py2.7.egg to /usr/share/clearwater/homestead/python/packages
    Adding homestead-prov 0.1 to easy-install.pth file

    Installed /usr/share/clearwater/homestead/python/packages/homestead_prov-0.1-py2.7.egg
    Processing dependencies for homestead-prov==0.1
    Finished processing dependencies for homestead-prov==0.1
     * Restarting clearwater-infrastructure clearwater-infrastructure
    mv: cannot move 鈥▒/tmp/hosts.1137鈥▒ to 鈥▒/etc/hosts鈥▒: Device or resource busy
     * Restarting DNS forwarder and DHCP server dnsmasq

    dnsmasq: setting capabilities failed: Operation not permitted
       ...fail!
    hostname: you must be root to change the host name
    mv: cannot move 鈥▒/tmp/hosts.1246鈥▒ to 鈥▒/etc/hosts鈥▒: Device or resource busy
    Configuring monit for only localhost access
       ...done.
    /var/lib/dpkg/info/homestead-prov.postinst: 69: /var/lib/dpkg/info/homestead-prov.postinst: /usr/share/clearwater/cassandra-schemas/homestead_provisioning.sh: not found
    Processing triggers for libc-bin (2.19-0ubuntu6.9) ...
    Processing triggers for sgml-base (1.26+nmu4ubuntu1) ...
    Processing triggers for ureadahead (0.100.0-16) ...
     ---> e5854d16214e
    Removing intermediate container 04d75fd05f12
    Step 6 : EXPOSE 8888 8889
     ---> Running in e1ffa240a3ab
     ---> 63ace52bb817
    Removing intermediate container e1ffa240a3ab
    Successfully built 63ace52bb817
