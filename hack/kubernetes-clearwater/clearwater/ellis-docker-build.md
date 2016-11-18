
### Build docker image

Customize `Dockerfile` to `docker build`

    [tangfx@localhost bono]$ mkdir -p ../ellis-docker && cd ../ellis-docker

    [tangfx@localhost ellis-docker]$ vi Dockerfile

    [tangfx@localhost ellis-docker]$ vi Makefile

    [tangfx@localhost ellis-docker]$ ls
    Dockerfile  Makefile

    [tangfx@localhost ellis-docker]$ make IMG_TAG=1611180614.gitrev-c2da9c9
    /usr/bin/docker build --tag=docker.io/tangfeixiong/clearwater-ellis:1611180614.gitrev-c2da9c9 --file=../../../../ellis/Dockerfile.tangfx ../../../../ellis
    Sending build context to Docker daemon 8.704 kB
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
     ---> 971f39810aaa
    Removing intermediate container 227b22ee0ccd
    Step 5 : RUN apt-get update &&   DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes mysql-server &&   /etc/init.d/mysql start &&   apt-get update &&   DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes ellis &&   /etc/init.d/mysql start &&   /usr/share/clearwater/ellis/env/bin/python /usr/share/clearwater/ellis/src/metaswitch/ellis/tools/create_numbers.py --start 6505550000 --count 1000 &&   mv /etc/supervisor/conf.d/ellis.supervisord.conf /etc/supervisor/conf.d/ellis.conf &&   mv /etc/supervisor/conf.d/mysql.supervisord.conf /etc/supervisor/conf.d/mysql.conf &&   mv /etc/supervisor/conf.d/nginx.supervisord.conf /etc/supervisor/conf.d/nginx.conf &&   mv /etc/supervisor/conf.d/clearwater-group.supervisord.conf /etc/supervisor/conf.d/clearwater-group.conf
     ---> Running in 5dda7c77353f
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
    Fetched 3,590 kB in 5s (640 kB/s)
    Reading package lists...
    W: Size of file /var/lib/apt/lists/mirrors.aliyun.com_ubuntu_dists_trusty-updates_universe_binary-amd64_Packages.gz is not what the server reported 501609 501619
    W: Size of file /var/lib/apt/lists/mirrors.aliyun.com_ubuntu_dists_trusty-security_main_source_Sources.gz is not what the server reported 153056 153059
    W: Size of file /var/lib/apt/lists/mirrors.aliyun.com_ubuntu_dists_trusty-security_main_binary-amd64_Packages.gz is not what the server reported 680542 680554
    W: Size of file /var/lib/apt/lists/mirrors.aliyun.com_ubuntu_dists_trusty-security_universe_binary-amd64_Packages.gz is not what the server reported 187712 187715
    Reading package lists...
    Building dependency tree...
    Reading state information...
    The following extra packages will be installed:
      libaio1 libdbd-mysql-perl libdbi-perl libhtml-template-perl libmysqlclient18
      libterm-readkey-perl mysql-client-5.5 mysql-client-core-5.5 mysql-common
      mysql-server-5.5 mysql-server-core-5.5 psmisc
    Suggested packages:
      libclone-perl libmldbm-perl libnet-daemon-perl libplrpc-perl
      libsql-statement-perl libipc-sharedcache-perl tinyca mailx
    The following NEW packages will be installed:
      libaio1 libdbd-mysql-perl libdbi-perl libhtml-template-perl libmysqlclient18
      libterm-readkey-perl mysql-client-5.5 mysql-client-core-5.5 mysql-common
      mysql-server mysql-server-5.5 mysql-server-core-5.5 psmisc
    0 upgraded, 13 newly installed, 0 to remove and 9 not upgraded.
    Need to get 9,310 kB of archives.
    After this operation, 97.3 MB of additional disk space will be used.
    Get:1 http://mirrors.aliyun.com/ubuntu/ trusty/main libaio1 amd64 0.3.109-4 [6,364 B]
    Get:2 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main mysql-common all 5.5.53-0ubuntu0.14.04.1 [13.0 kB]
    Get:3 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libmysqlclient18 amd64 5.5.53-0ubuntu0.14.04.1 [597 kB]
    Get:4 http://mirrors.aliyun.com/ubuntu/ trusty/main libdbi-perl amd64 1.630-1 [879 kB]
    Get:5 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libdbd-mysql-perl amd64 4.025-1ubuntu0.1 [87.6 kB]
    Get:6 http://mirrors.aliyun.com/ubuntu/ trusty/main libterm-readkey-perl amd64 2.31-1 [27.4 kB]
    Get:7 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main mysql-client-core-5.5 amd64 5.5.53-0ubuntu0.14.04.1 [708 kB]
    Get:8 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main mysql-client-5.5 amd64 5.5.53-0ubuntu0.14.04.1 [1,587 kB]
    Get:9 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main mysql-server-core-5.5 amd64 5.5.53-0ubuntu0.14.04.1 [3,284 kB]
    Get:10 http://mirrors.aliyun.com/ubuntu/ trusty/main psmisc amd64 22.20-1ubuntu2 [53.2 kB]
    Get:11 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main mysql-server-5.5 amd64 5.5.53-0ubuntu0.14.04.1 [1,990 kB]
    Get:12 http://mirrors.aliyun.com/ubuntu/ trusty/main libhtml-template-perl all 2.95-1 [65.5 kB]
    Get:13 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main mysql-server all 5.5.53-0ubuntu0.14.04.1 [11.3 kB]
    Preconfiguring packages ...
    Fetched 9,310 kB in 13s (668 kB/s)
    Selecting previously unselected package libaio1:amd64.
    (Reading database ... 24489 files and directories currently installed.)
    Preparing to unpack .../libaio1_0.3.109-4_amd64.deb ...
    Unpacking libaio1:amd64 (0.3.109-4) ...
    Selecting previously unselected package mysql-common.
    Preparing to unpack .../mysql-common_5.5.53-0ubuntu0.14.04.1_all.deb ...
    Unpacking mysql-common (5.5.53-0ubuntu0.14.04.1) ...
    Selecting previously unselected package libmysqlclient18:amd64.
    Preparing to unpack .../libmysqlclient18_5.5.53-0ubuntu0.14.04.1_amd64.deb ...
    Unpacking libmysqlclient18:amd64 (5.5.53-0ubuntu0.14.04.1) ...
    Selecting previously unselected package libdbi-perl.
    Preparing to unpack .../libdbi-perl_1.630-1_amd64.deb ...
    Unpacking libdbi-perl (1.630-1) ...
    Selecting previously unselected package libdbd-mysql-perl.
    Preparing to unpack .../libdbd-mysql-perl_4.025-1ubuntu0.1_amd64.deb ...
    Unpacking libdbd-mysql-perl (4.025-1ubuntu0.1) ...
    Selecting previously unselected package libterm-readkey-perl.
    Preparing to unpack .../libterm-readkey-perl_2.31-1_amd64.deb ...
    Unpacking libterm-readkey-perl (2.31-1) ...
    Selecting previously unselected package mysql-client-core-5.5.
    Preparing to unpack .../mysql-client-core-5.5_5.5.53-0ubuntu0.14.04.1_amd64.deb ...
    Unpacking mysql-client-core-5.5 (5.5.53-0ubuntu0.14.04.1) ...
    Selecting previously unselected package mysql-client-5.5.
    Preparing to unpack .../mysql-client-5.5_5.5.53-0ubuntu0.14.04.1_amd64.deb ...
    Unpacking mysql-client-5.5 (5.5.53-0ubuntu0.14.04.1) ...
    Selecting previously unselected package mysql-server-core-5.5.
    Preparing to unpack .../mysql-server-core-5.5_5.5.53-0ubuntu0.14.04.1_amd64.deb ...
    Unpacking mysql-server-core-5.5 (5.5.53-0ubuntu0.14.04.1) ...
    Selecting previously unselected package psmisc.
    Preparing to unpack .../psmisc_22.20-1ubuntu2_amd64.deb ...
    Unpacking psmisc (22.20-1ubuntu2) ...
    Setting up mysql-common (5.5.53-0ubuntu0.14.04.1) ...
    Selecting previously unselected package mysql-server-5.5.
    (Reading database ... 24872 files and directories currently installed.)
    Preparing to unpack .../mysql-server-5.5_5.5.53-0ubuntu0.14.04.1_amd64.deb ...
    Unpacking mysql-server-5.5 (5.5.53-0ubuntu0.14.04.1) ...
    Selecting previously unselected package libhtml-template-perl.
    Preparing to unpack .../libhtml-template-perl_2.95-1_all.deb ...
    Unpacking libhtml-template-perl (2.95-1) ...
    Selecting previously unselected package mysql-server.
    Preparing to unpack .../mysql-server_5.5.53-0ubuntu0.14.04.1_all.deb ...
    Unpacking mysql-server (5.5.53-0ubuntu0.14.04.1) ...
    Processing triggers for ureadahead (0.100.0-16) ...
    Setting up libaio1:amd64 (0.3.109-4) ...
    Setting up libmysqlclient18:amd64 (5.5.53-0ubuntu0.14.04.1) ...
    Setting up libdbi-perl (1.630-1) ...
    Setting up libdbd-mysql-perl (4.025-1ubuntu0.1) ...
    Setting up libterm-readkey-perl (2.31-1) ...
    Setting up mysql-client-core-5.5 (5.5.53-0ubuntu0.14.04.1) ...
    Setting up mysql-client-5.5 (5.5.53-0ubuntu0.14.04.1) ...
    Setting up mysql-server-core-5.5 (5.5.53-0ubuntu0.14.04.1) ...
    Setting up psmisc (22.20-1ubuntu2) ...
    Setting up mysql-server-5.5 (5.5.53-0ubuntu0.14.04.1) ...
    invoke-rc.d: policy-rc.d denied execution of stop.
    invoke-rc.d: policy-rc.d denied execution of start.
    Setting up libhtml-template-perl (2.95-1) ...
    Processing triggers for ureadahead (0.100.0-16) ...
    Setting up mysql-server (5.5.53-0ubuntu0.14.04.1) ...
    Processing triggers for libc-bin (2.19-0ubuntu6.9) ...
     * Starting MySQL database server mysqld
       ...done.
     * Checking for tables which need an upgrade, are corrupt or were
    not closed cleanly.
    Ign http://10.64.33.1:48080 binary/ InRelease
    Hit http://10.64.33.1:48080 binary/ Release.gpg
    Hit http://10.64.33.1:48080 binary/ Release
    Ign http://mirrors.aliyun.com trusty InRelease
    Hit http://mirrors.aliyun.com trusty-updates InRelease
    Hit http://mirrors.aliyun.com trusty-security InRelease
    Hit http://10.64.33.1:48080 binary/ Packages
    Hit http://mirrors.aliyun.com trusty Release.gpg
    Hit http://mirrors.aliyun.com trusty-updates/main Sources
    Hit http://mirrors.aliyun.com trusty-updates/restricted Sources
    Hit http://mirrors.aliyun.com trusty-updates/universe Sources
    Hit http://mirrors.aliyun.com trusty-updates/main amd64 Packages
    Hit http://mirrors.aliyun.com trusty-updates/restricted amd64 Packages
    Hit http://mirrors.aliyun.com trusty-updates/universe amd64 Packages
    Hit http://mirrors.aliyun.com trusty Release
    Hit http://mirrors.aliyun.com trusty-security/main Sources
    Hit http://mirrors.aliyun.com trusty-security/restricted Sources
    Hit http://mirrors.aliyun.com trusty-security/universe Sources
    Hit http://mirrors.aliyun.com trusty-security/main amd64 Packages
    Hit http://mirrors.aliyun.com trusty-security/restricted amd64 Packages
    Hit http://mirrors.aliyun.com trusty-security/universe amd64 Packages
    Hit http://mirrors.aliyun.com trusty/main Sources
    Hit http://mirrors.aliyun.com trusty/restricted Sources
    Hit http://mirrors.aliyun.com trusty/universe Sources
    Hit http://mirrors.aliyun.com trusty/main amd64 Packages
    Hit http://mirrors.aliyun.com trusty/restricted amd64 Packages
    Hit http://mirrors.aliyun.com trusty/universe amd64 Packages
    Reading package lists...
    Reading package lists...
    Building dependency tree...
    Reading state information...
    The following extra packages will be installed:
      clearwater-log-cleanup clearwater-nginx fontconfig-config fonts-dejavu-core
      geoip-database libfontconfig1 libfreetype6 libgd3 libgeoip1 libjbig0
      libjpeg-turbo8 libjpeg8 libtiff5 libvpx1 libxml2 libxpm4 libxslt1.1 nginx
      nginx-common nginx-core sgml-base xml-core
    Suggested packages:
      clearwater-snmp-handler-alarm clearwater-logging clearwater-snmpd
      libgd-tools geoip-bin fcgiwrap nginx-doc sgml-base-doc debhelper
    The following NEW packages will be installed:
      clearwater-log-cleanup clearwater-nginx ellis fontconfig-config
      fonts-dejavu-core geoip-database libfontconfig1 libfreetype6 libgd3
      libgeoip1 libjbig0 libjpeg-turbo8 libjpeg8 libtiff5 libvpx1 libxml2 libxpm4
      libxslt1.1 nginx nginx-common nginx-core sgml-base xml-core
    0 upgraded, 23 newly installed, 0 to remove and 9 not upgraded.
    Need to get 16.4 MB of archives.
    After this operation, 30.8 MB of additional disk space will be used.
    Get:1 http://10.64.33.1:48080/mirror/repo.cw-ngv.com/stable/ binary/ clearwater-log-cleanup 1.0-161102.114310 [13.3 kB]
    Get:2 http://10.64.33.1:48080/mirror/repo.cw-ngv.com/stable/ binary/ clearwater-nginx 1.0-161028.000011 [19.7 kB]
    Get:3 http://10.64.33.1:48080/mirror/repo.cw-ngv.com/stable/ binary/ ellis 1.0-161104.121210 [11.5 MB]
    Get:4 http://mirrors.aliyun.com/ubuntu/ trusty/main libgeoip1 amd64 1.6.0-1 [71.0 kB]
    Get:5 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libxml2 amd64 2.9.1+dfsg1-3ubuntu4.8 [573 kB]
    Get:6 http://mirrors.aliyun.com/ubuntu/ trusty/main sgml-base all 1.26+nmu4ubuntu1 [12.5 kB]
    Get:7 http://mirrors.aliyun.com/ubuntu/ trusty/main fonts-dejavu-core all 2.34-1ubuntu1 [1,024 kB]
    Get:8 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main fontconfig-config all 2.11.0-0ubuntu4.2 [47.4 kB]
    Get:9 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libfreetype6 amd64 2.5.2-1ubuntu2.5 [304 kB]
    Get:10 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libfontconfig1 amd64 2.11.0-0ubuntu4.2 [123 kB]
    Get:11 http://mirrors.aliyun.com/ubuntu/ trusty/main libjpeg-turbo8 amd64 1.3.0-0ubuntu2 [104 kB]
    Get:12 http://mirrors.aliyun.com/ubuntu/ trusty/main libjpeg8 amd64 8c-2ubuntu8 [2,194 B]
    Get:13 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libjbig0 amd64 2.0-2ubuntu4.1 [26.1 kB]
    Get:14 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libtiff5 amd64 4.0.3-7ubuntu0.4 [143 kB]
    Get:15 http://mirrors.aliyun.com/ubuntu/ trusty/main libvpx1 amd64 1.3.0-2 [556 kB]
    Get:16 http://mirrors.aliyun.com/ubuntu/ trusty/main libxpm4 amd64 1:3.5.10-1 [38.3 kB]
    Get:17 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main libgd3 amd64 2.1.0-3ubuntu0.5 [122 kB]
    Get:18 http://mirrors.aliyun.com/ubuntu/ trusty/main libxslt1.1 amd64 1.1.28-2build1 [145 kB]
    Get:19 http://mirrors.aliyun.com/ubuntu/ trusty/main geoip-database all 20140313-1 [1,196 kB]
    Get:20 http://mirrors.aliyun.com/ubuntu/ trusty/main xml-core all 0.13+nmu2 [23.3 kB]
    Get:21 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main nginx-common all 1.4.6-1ubuntu3.7 [19.0 kB]
    Get:22 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main nginx-core amd64 1.4.6-1ubuntu3.7 [325 kB]
    Get:23 http://mirrors.aliyun.com/ubuntu/ trusty-updates/main nginx all 1.4.6-1ubuntu3.7 [5,352 B]
    Preconfiguring packages ...
    Fetched 16.4 MB in 4s (3,948 kB/s)
    Selecting previously unselected package libgeoip1:amd64.
    (Reading database ... 24973 files and directories currently installed.)
    Preparing to unpack .../libgeoip1_1.6.0-1_amd64.deb ...
    Unpacking libgeoip1:amd64 (1.6.0-1) ...
    Selecting previously unselected package libxml2:amd64.
    Preparing to unpack .../libxml2_2.9.1+dfsg1-3ubuntu4.8_amd64.deb ...
    Unpacking libxml2:amd64 (2.9.1+dfsg1-3ubuntu4.8) ...
    Selecting previously unselected package sgml-base.
    Preparing to unpack .../sgml-base_1.26+nmu4ubuntu1_all.deb ...
    Unpacking sgml-base (1.26+nmu4ubuntu1) ...
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
    Selecting previously unselected package ellis.
    Preparing to unpack .../ellis_1.0-161104.121210_amd64.deb ...
    Unpacking ellis (1.0-161104.121210) ...
    Processing triggers for ureadahead (0.100.0-16) ...
    Setting up libgeoip1:amd64 (1.6.0-1) ...
    Setting up libxml2:amd64 (2.9.1+dfsg1-3ubuntu4.8) ...
    Setting up sgml-base (1.26+nmu4ubuntu1) ...
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
    Setting up libxslt1.1:amd64 (1.1.28-2build1) ...
    Setting up geoip-database (20140313-1) ...
    Setting up xml-core (0.13+nmu2) ...
    Setting up clearwater-log-cleanup (1.0-161102.114310) ...
    Setting up nginx-common (1.4.6-1ubuntu3.7) ...
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
    ............................+++
    ..................................................................................................................+++
    writing new private key to 'nginx.key'
    -----
    Signature ok
    subject=/C=UK/ST=Unknown state/L=Unknown locality/O=Unknown organization/OU=Unknown organizational unit/CN=unknown.example/emailAddress=Unknown
    Getting Private key
    Adding 'diversion of /etc/nginx/nginx.conf to /etc/nginx/nginx.conf.clearwater-orig by clearwater-nginx'
    Setting up ellis (1.0-161104.121210) ...
    usermod: no changes
    Already using interpreter /usr/bin/python
    New python executable in /usr/share/clearwater/ellis/env/bin/python
    Installing setuptools, pip...done.
    Processing MySQL_python-1.2.5-py2.7-linux-x86_64.egg
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/MySQL_python-1.2.5-py2.7-linux-x86_64.egg
    Extracting MySQL_python-1.2.5-py2.7-linux-x86_64.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    Adding MySQL-python 1.2.5 to easy-install.pth file

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/MySQL_python-1.2.5-py2.7-linux-x86_64.egg
    Processing dependencies for MySQL-python==1.2.5
    Finished processing dependencies for MySQL-python==1.2.5
    Processing SQLAlchemy-1.0.9-py2.7-linux-x86_64.egg
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/SQLAlchemy-1.0.9-py2.7-linux-x86_64.egg
    Extracting SQLAlchemy-1.0.9-py2.7-linux-x86_64.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    Adding SQLAlchemy 1.0.9 to easy-install.pth file

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/SQLAlchemy-1.0.9-py2.7-linux-x86_64.egg
    Processing dependencies for SQLAlchemy==1.0.9
    Finished processing dependencies for SQLAlchemy==1.0.9
    Processing cffi-1.5.2-py2.7-linux-x86_64.egg
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/cffi-1.5.2-py2.7-linux-x86_64.egg
    Extracting cffi-1.5.2-py2.7-linux-x86_64.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    Adding cffi 1.5.2 to easy-install.pth file

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/cffi-1.5.2-py2.7-linux-x86_64.egg
    Processing dependencies for cffi==1.5.2
    Searching for pycparser
    Best match: pycparser 2.17
    Processing pycparser-2.17-py2.7.egg
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pycparser-2.17-py2.7.egg
    Extracting pycparser-2.17-py2.7.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    Adding pycparser 2.17 to easy-install.pth file

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pycparser-2.17-py2.7.egg
    Finished processing dependencies for cffi==1.5.2
    Processing ellis-0.1-py2.7.egg
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/ellis-0.1-py2.7.egg
    Extracting ellis-0.1-py2.7.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    Adding ellis 0.1 to easy-install.pth file

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/ellis-0.1-py2.7.egg
    Processing dependencies for ellis==0.1
    Searching for pycurl==7.43.0
    Best match: pycurl 7.43.0
    Processing pycurl-7.43.0-py2.7-linux-x86_64.egg
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pycurl-7.43.0-py2.7-linux-x86_64.egg
    Extracting pycurl-7.43.0-py2.7-linux-x86_64.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    Adding pycurl 7.43.0 to easy-install.pth file

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pycurl-7.43.0-py2.7-linux-x86_64.egg
    Searching for prctl==1.0.1
    Best match: prctl 1.0.1
    Processing prctl-1.0.1-py2.7-linux-x86_64.egg
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/prctl-1.0.1-py2.7-linux-x86_64.egg
    Extracting prctl-1.0.1-py2.7-linux-x86_64.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    Adding prctl 1.0.1 to easy-install.pth file

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/prctl-1.0.1-py2.7-linux-x86_64.egg
    Searching for phonenumbers==7.1.1
    Best match: phonenumbers 7.1.1
    Processing phonenumbers-7.1.1-py2.7.egg
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/phonenumbers-7.1.1-py2.7.egg
    Extracting phonenumbers-7.1.1-py2.7.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    Adding phonenumbers 7.1.1 to easy-install.pth file

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/phonenumbers-7.1.1-py2.7.egg
    Searching for msgpack-python==0.4.6
    Best match: msgpack-python 0.4.6
    Processing msgpack_python-0.4.6-py2.7-linux-x86_64.egg
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/msgpack_python-0.4.6-py2.7-linux-x86_64.egg
    Extracting msgpack_python-0.4.6-py2.7-linux-x86_64.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    Adding msgpack-python 0.4.6 to easy-install.pth file

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/msgpack_python-0.4.6-py2.7-linux-x86_64.egg
    Searching for tornado==2.3
    Best match: tornado 2.3
    Processing tornado-2.3-py2.7.egg
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/tornado-2.3-py2.7.egg
    Extracting tornado-2.3-py2.7.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    Adding tornado 2.3 to easy-install.pth file

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/tornado-2.3-py2.7.egg
    Searching for py-bcrypt==0.4
    Best match: py-bcrypt 0.4
    Processing py_bcrypt-0.4-py2.7-linux-x86_64.egg
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/py_bcrypt-0.4-py2.7-linux-x86_64.egg
    Extracting py_bcrypt-0.4-py2.7-linux-x86_64.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    Adding py-bcrypt 0.4 to easy-install.pth file

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/py_bcrypt-0.4-py2.7-linux-x86_64.egg
    Finished processing dependencies for ellis==0.1
    Processing funcsigs-1.0.2-py2.7.egg
    Copying funcsigs-1.0.2-py2.7.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    Adding funcsigs 1.0.2 to easy-install.pth file

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/funcsigs-1.0.2-py2.7.egg
    Processing dependencies for funcsigs==1.0.2
    Finished processing dependencies for funcsigs==1.0.2
    Processing metaswitchcommon-0.1-py2.7-linux-x86_64.egg
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/metaswitchcommon-0.1-py2.7-linux-x86_64.egg
    Extracting metaswitchcommon-0.1-py2.7-linux-x86_64.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    Adding metaswitchcommon 0.1 to easy-install.pth file

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/metaswitchcommon-0.1-py2.7-linux-x86_64.egg
    Processing dependencies for metaswitchcommon==0.1
    Searching for monotonic==0.6
    Best match: monotonic 0.6
    Processing monotonic-0.6-py2.7.egg
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/monotonic-0.6-py2.7.egg
    Extracting monotonic-0.6-py2.7.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    Adding monotonic 0.6 to easy-install.pth file

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/monotonic-0.6-py2.7.egg
    Searching for pyzmq==15.2
    Best match: pyzmq 15.2.0
    Processing pyzmq-15.2.0-py2.7-linux-x86_64.egg
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg
    Extracting pyzmq-15.2.0-py2.7-linux-x86_64.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
      File "/usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg/zmq/asyncio.py", line 79
        "{!r}".format(fileobj)) from None
                                   ^
    SyntaxError: invalid syntax

      File "/usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg/zmq/tests/_test_asyncio.py", line 43
        yield from a.send(b'hi')
                 ^
    SyntaxError: invalid syntax

      File "/usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg/zmq/auth/asyncio.py", line 28
        events = yield from self.__poller.poll()
                          ^
    SyntaxError: invalid syntax

    Adding pyzmq 15.2.0 to easy-install.pth file

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg
    Searching for pycrypto==2.6.1
    Best match: pycrypto 2.6.1
    Processing pycrypto-2.6.1-py2.7-linux-x86_64.egg
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pycrypto-2.6.1-py2.7-linux-x86_64.egg
    Extracting pycrypto-2.6.1-py2.7-linux-x86_64.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    Adding pycrypto 2.6.1 to easy-install.pth file

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pycrypto-2.6.1-py2.7-linux-x86_64.egg
    Finished processing dependencies for metaswitchcommon==0.1
    Processing mock-2.0.0-py2.7.egg
    Copying mock-2.0.0-py2.7.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    Adding mock 2.0.0 to easy-install.pth file

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/mock-2.0.0-py2.7.egg
    Processing dependencies for mock==2.0.0
    Searching for six>=1.9
    Best match: six 1.10.0
    Processing six-1.10.0-py2.7.egg
    Copying six-1.10.0-py2.7.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    Adding six 1.10.0 to easy-install.pth file

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/six-1.10.0-py2.7.egg
    Searching for pbr>=0.11
    Best match: pbr 1.6.0
    Processing pbr-1.6.0-py2.7.egg
    Copying pbr-1.6.0-py2.7.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    Adding pbr 1.6.0 to easy-install.pth file
    Installing pbr script to /usr/share/clearwater/ellis/env/bin

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pbr-1.6.0-py2.7.egg
    Finished processing dependencies for mock==2.0.0
    Processing monotonic-0.6-py2.7.egg
    removing '/usr/share/clearwater/ellis/env/lib/python2.7/site-packages/monotonic-0.6-py2.7.egg' (and everything under it)
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/monotonic-0.6-py2.7.egg
    Extracting monotonic-0.6-py2.7.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    monotonic 0.6 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/monotonic-0.6-py2.7.egg
    Processing dependencies for monotonic==0.6
    Finished processing dependencies for monotonic==0.6
    Processing msgpack_python-0.4.6-py2.7-linux-x86_64.egg
    removing '/usr/share/clearwater/ellis/env/lib/python2.7/site-packages/msgpack_python-0.4.6-py2.7-linux-x86_64.egg' (and everything under it)
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/msgpack_python-0.4.6-py2.7-linux-x86_64.egg
    Extracting msgpack_python-0.4.6-py2.7-linux-x86_64.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    msgpack-python 0.4.6 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/msgpack_python-0.4.6-py2.7-linux-x86_64.egg
    Processing dependencies for msgpack-python==0.4.6
    Finished processing dependencies for msgpack-python==0.4.6
    Processing pbr-1.6.0-py2.7.egg
    removing '/usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pbr-1.6.0-py2.7.egg' (and everything under it)
    Copying pbr-1.6.0-py2.7.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    pbr 1.6.0 is already the active version in easy-install.pth
    Installing pbr script to /usr/share/clearwater/ellis/env/bin

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pbr-1.6.0-py2.7.egg
    Processing dependencies for pbr==1.6.0
    Finished processing dependencies for pbr==1.6.0
    Processing phonenumbers-7.1.1-py2.7.egg
    removing '/usr/share/clearwater/ellis/env/lib/python2.7/site-packages/phonenumbers-7.1.1-py2.7.egg' (and everything under it)
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/phonenumbers-7.1.1-py2.7.egg
    Extracting phonenumbers-7.1.1-py2.7.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    phonenumbers 7.1.1 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/phonenumbers-7.1.1-py2.7.egg
    Processing dependencies for phonenumbers==7.1.1
    Finished processing dependencies for phonenumbers==7.1.1
    Processing prctl-1.0.1-py2.7-linux-x86_64.egg
    removing '/usr/share/clearwater/ellis/env/lib/python2.7/site-packages/prctl-1.0.1-py2.7-linux-x86_64.egg' (and everything under it)
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/prctl-1.0.1-py2.7-linux-x86_64.egg
    Extracting prctl-1.0.1-py2.7-linux-x86_64.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    prctl 1.0.1 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/prctl-1.0.1-py2.7-linux-x86_64.egg
    Processing dependencies for prctl==1.0.1
    Finished processing dependencies for prctl==1.0.1
    Processing py_bcrypt-0.4-py2.7-linux-x86_64.egg
    removing '/usr/share/clearwater/ellis/env/lib/python2.7/site-packages/py_bcrypt-0.4-py2.7-linux-x86_64.egg' (and everything under it)
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/py_bcrypt-0.4-py2.7-linux-x86_64.egg
    Extracting py_bcrypt-0.4-py2.7-linux-x86_64.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    py-bcrypt 0.4 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/py_bcrypt-0.4-py2.7-linux-x86_64.egg
    Processing dependencies for py-bcrypt==0.4
    Finished processing dependencies for py-bcrypt==0.4
    Processing pycparser-2.17-py2.7.egg
    removing '/usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pycparser-2.17-py2.7.egg' (and everything under it)
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pycparser-2.17-py2.7.egg
    Extracting pycparser-2.17-py2.7.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    pycparser 2.17 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pycparser-2.17-py2.7.egg
    Processing dependencies for pycparser==2.17
    Finished processing dependencies for pycparser==2.17
    Processing pycrypto-2.6.1-py2.7-linux-x86_64.egg
    removing '/usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pycrypto-2.6.1-py2.7-linux-x86_64.egg' (and everything under it)
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pycrypto-2.6.1-py2.7-linux-x86_64.egg
    Extracting pycrypto-2.6.1-py2.7-linux-x86_64.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    pycrypto 2.6.1 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pycrypto-2.6.1-py2.7-linux-x86_64.egg
    Processing dependencies for pycrypto==2.6.1
    Finished processing dependencies for pycrypto==2.6.1
    Processing pycurl-7.43.0-py2.7-linux-x86_64.egg
    removing '/usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pycurl-7.43.0-py2.7-linux-x86_64.egg' (and everything under it)
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pycurl-7.43.0-py2.7-linux-x86_64.egg
    Extracting pycurl-7.43.0-py2.7-linux-x86_64.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    pycurl 7.43.0 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pycurl-7.43.0-py2.7-linux-x86_64.egg
    Processing dependencies for pycurl==7.43.0
    Finished processing dependencies for pycurl==7.43.0
    Processing pyzmq-15.2.0-py2.7-linux-x86_64.egg
    removing '/usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg' (and everything under it)
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg
    Extracting pyzmq-15.2.0-py2.7-linux-x86_64.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
      File "/usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg/zmq/asyncio.py", line 79
        "{!r}".format(fileobj)) from None
                                   ^
    SyntaxError: invalid syntax

      File "/usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg/zmq/tests/_test_asyncio.py", line 43
        yield from a.send(b'hi')
                 ^
    SyntaxError: invalid syntax

      File "/usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg/zmq/auth/asyncio.py", line 28
        events = yield from self.__poller.poll()
                          ^
    SyntaxError: invalid syntax

    pyzmq 15.2.0 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/pyzmq-15.2.0-py2.7-linux-x86_64.egg
    Processing dependencies for pyzmq==15.2.0
    Finished processing dependencies for pyzmq==15.2.0
    Processing six-1.10.0-py2.7.egg
    removing '/usr/share/clearwater/ellis/env/lib/python2.7/site-packages/six-1.10.0-py2.7.egg' (and everything under it)
    Copying six-1.10.0-py2.7.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    six 1.10.0 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/six-1.10.0-py2.7.egg
    Processing dependencies for six==1.10.0
    Finished processing dependencies for six==1.10.0
    Processing tornado-2.3-py2.7.egg
    removing '/usr/share/clearwater/ellis/env/lib/python2.7/site-packages/tornado-2.3-py2.7.egg' (and everything under it)
    creating /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/tornado-2.3-py2.7.egg
    Extracting tornado-2.3-py2.7.egg to /usr/share/clearwater/ellis/env/lib/python2.7/site-packages
    tornado 2.3 is already the active version in easy-install.pth

    Installed /usr/share/clearwater/ellis/env/lib/python2.7/site-packages/tornado-2.3-py2.7.egg
    Processing dependencies for tornado==2.3
    Finished processing dependencies for tornado==2.3
     * Restarting clearwater-infrastructure clearwater-infrastructure
    mv: cannot move 鈥▒/tmp/hosts.1501鈥▒ to 鈥▒/etc/hosts鈥▒: Device or resource busy
     * Restarting DNS forwarder and DHCP server dnsmasq

    dnsmasq: setting capabilities failed: Operation not permitted
       ...fail!
    nginx: [warn] conflicting server name "10.120.160.2" on [::]:80, ignored
    nginx: [warn] conflicting server name "10.120.160.2" on [::]:80, ignored
    nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
    nginx: configuration file /etc/nginx/nginx.conf test is successful
    hostname: you must be root to change the host name
    mv: cannot move 鈥▒/tmp/hosts.1585鈥▒ to 鈥▒/etc/hosts鈥▒: Device or resource busy
    Configuring monit for only localhost access
       ...done.
    Processing triggers for libc-bin (2.19-0ubuntu6.9) ...
    Processing triggers for sgml-base (1.26+nmu4ubuntu1) ...
    Processing triggers for ureadahead (0.100.0-16) ...
     * Starting MySQL database server mysqld
       ...done.
    Created 1000 numbers, 0 already present in database
     ---> 817d2931fb2c
    Removing intermediate container 5dda7c77353f
    Step 6 : EXPOSE 80
     ---> Running in 51102525dca1
     ---> b7b794efd5f8
    Removing intermediate container 51102525dca1
    Successfully built b7b794efd5f8
