Instruction
============

After installed CentOS box

    tangf@DESKTOP-H68OQDV /cygdrive/g/atlas.hashicorp.com/centos/boxes/7
    $ vagrant ssh
    Last login: Mon Nov  7 11:36:53 2016 from 10.0.2.2

    [vagrant@localhost ~]$ sudo systemctl list-unit-files docker.service
    UNIT FILE STATE

    0 unit files listed.

CentOS7.2的docker RPM packages

    [vagrant@localhost ~]$ sudo yum list docker
    Loaded plugins: fastestmirror
    base                                                     | 3.6 kB     00:00
    extras                                                   | 3.4 kB     00:00
    updates                                                  | 3.4 kB     00:00
    (1/4): base/7/x86_64/group_gz                              | 155 kB   00:00
    (2/4): extras/7/x86_64/primary_db                          | 166 kB   00:02
    (3/4): updates/7/x86_64/primary_db                         | 9.1 MB   00:16
    (4/4): base/7/x86_64/primary_db                            | 5.3 MB   00:36
    Determining fastest mirrors
     * base: mirror.lzu.edu.cn
     * extras: mirrors.zju.edu.cn
     * updates: mirrors.zju.edu.cn
    Available Packages
    docker.x86_64                   1.10.3-46.el7.centos.14                   extras

POC
----

[Official site](http://mirror.centos.org/centos/7/paas/x86_64/openshift-origin/)

[Mirror list](https://www.centos.org/download/mirrors/)

[阿里云](http://mirrors.aliyun.com/docker-engine/)

For rsync => rsync://mirrors.yun-idc.com/centos/

* Sync CentOS for example Extras repo

[脚本](./scripts)参见scripts目录

    tangf@DESKTOP-H68OQDV /cygdrive/g/2015-12-19-repository/99-mirror/centos
    $ ./mirror-by-rsync.sh

* A windows hosted scratch file server （written by Golang）

[代码](./gofileserver)参见gofileserver目录

    tangf@DESKTOP-H68OQDV /cygdrive/g/2015-12-19-repository/99-mirror/centos/rsync%3A%2F%2Fmirrors.yun-idc.com%2Fcentos%2F7
    $ gofileserver.exe
    Listening at  :48080

* Configure into CentOS box

设置Extras repo

    [vagrant@localhost ~]$ sudo yum-config-manager --disable extras
    Loaded plugins: fastestmirror
    ================================= repo: extras =================================
    [extras]
    async = True
    bandwidth = 0
    base_persistdir = /var/lib/yum/repos/x86_64/7
    baseurl =
    cache = 0
    cachedir = /var/cache/yum/x86_64/7/extras
    check_config_file_age = True
    cost = 1000
    deltarpm_metadata_percentage = 100
    deltarpm_percentage =
    enabled = 0
    enablegroups = True
    exclude =
    failovermethod = priority
    gpgcadir = /var/lib/yum/repos/x86_64/7/extras/gpgcadir
    gpgcakey =
    gpgcheck = True
    gpgdir = /var/lib/yum/repos/x86_64/7/extras/gpgdir
    gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
    hdrdir = /var/cache/yum/x86_64/7/extras/headers
    http_caching = all
    includepkgs =
    ip_resolve =
    keepalive = True
    keepcache = False
    mddownloadpolicy = sqlite
    mdpolicy = group:small
    mediaid =
    metadata_expire = 21600
    metadata_expire_filter = read-only:present
    metalink =
    minrate = 0
    mirrorlist = http://mirrorlist.centos.org/?release=7&arch=x86_64&repo=extras&infra=vag
    mirrorlist_expire = 86400
    name = CentOS-7 - Extras
    old_base_cache_dir =
    password =
    persistdir = /var/lib/yum/repos/x86_64/7/extras
    pkgdir = /var/cache/yum/x86_64/7/extras/packages
    proxy = False
    proxy_dict =
    proxy_password =
    proxy_username =
    repo_gpgcheck = False
    retries = 10
    skip_if_unavailable = False
    ssl_check_cert_permissions = True
    sslcacert =
    sslclientcert =
    sslclientkey =
    sslverify = True
    throttle = 0
    timeout = 30.0
    ui_id = extras/7/x86_64
    ui_repoid_vars = releasever,
       basearch
    username =

    [vagrant@localhost ~]$ sudo tee /etc/yum.repos.d/local-mirror-extras.repo <<- 'EOF'
    > [extras-mirror]
    > name=CentOS-7 - Extras
    > baseurl=http://192.168.1.100:48080/extras/x86_64
    > enabled=1
    > gpgcheck=1
    > gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
    > EOF

    [extras-mirror]
    name=CentOS-7 - Extras
    baseurl=http://192.168.1.100:48080/extras/x86_64
    enabled=1
    gpgcheck=1
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7


Experimental ops

    [vagrant@localhost ~]$ sudo yum repolist                                        Loaded plugins: fastestmirror
    base                                                     | 3.6 kB     00:00
    centos-openshift-origin                                  | 2.9 kB     00:00
    extras                                                   | 3.4 kB     00:00
    updates                                                  | 3.4 kB     00:00
    centos-openshift-origin/primary_db                         |  87 kB   00:01
    Loading mirror speeds from cached hostfile
     * base: mirrors.zju.edu.cn
     * extras: mirrors.zju.edu.cn
     * updates: mirrors.zju.edu.cn
    repo id                              repo name                            status
    base/7/x86_64                        CentOS-7 - Base                      9,007
    centos-openshift-origin              CentOS OpenShift Origin                107
    extras/7/x86_64                      CentOS-7 - Extras                      393
    updates/7/x86_64                     CentOS-7 - Updates                   2,560
    repolist: 12,067

    [vagrant@localhost ~]$ sudo yum --disablerepo=extras,centos-openshift-origin --enablerepo=extras-mirror,centos-openshift-origin-mirror repolist
    Loaded plugins: fastestmirror
    Loading mirror speeds from cached hostfile
     * base: mirrors.zju.edu.cn
     * updates: mirrors.zju.edu.cn
    repo id                                  repo name                        status
    base/7/x86_64                            CentOS-7 - Base                  9,007
    !centos-openshift-origin-mirror          CentOS Openshift Origin            107
    !extras-mirror                           CentOS-7 - Extras                  393
    updates/7/x86_64                         CentOS-7 - Updates               2,560
    repolist: 12,067

* Install docker

参考[docker官方文档](https://docs.docker.com/engine/installation/linux/centos/)

    [vagrant@localhost ~]$ sudo systemctl enable docker.service

    [vagrant@localhost ~]$ sudo systemctl start docker.service

Validation

    [vagrant@localhost ~]$ sudo systemctl -l status docker.service
    鈼▒ docker.service - Docker Application Container Engine
       Loaded: loaded (/usr/lib/systemd/system/docker.service; enabled; vendor preset: disabled)
      Drop-In: /usr/lib/systemd/system/docker.service.d
               鈹斺攢flannel.conf
       Active: active (running) since Sat 2016-11-12 22:43:09 UTC; 10s ago
         Docs: http://docs.docker.com
     Main PID: 13547 (docker-current)
       CGroup: /system.slice/docker.service
               鈹斺攢13547 /usr/bin/docker-current daemon --exec-opt native.cgroupdriver=systemd --selinux-enabled --log-driver=journald --bip=10.121.24.1/23 --ip-masq=true --mtu=1472

    Nov 12 22:43:09 localhost.localdomain docker-current[13547]: time="2016-11-12T22:43:09.824941328Z" level=warning msg="devmapper: Base device already exists and has filesystem xfs on it. User specified filesystem  will be ignored."
    Nov 12 22:43:09 localhost.localdomain docker-current[13547]: time="2016-11-12T22:43:09.847090355Z" level=info msg="[graphdriver] using prior storage driver \"devicemapper\""
    Nov 12 22:43:09 localhost.localdomain docker-current[13547]: time="2016-11-12T22:43:09.849853203Z" level=info msg="Graph migration to content-addressability took 0.00 seconds"
    Nov 12 22:43:09 localhost.localdomain docker-current[13547]: time="2016-11-12T22:43:09.856844053Z" level=info msg="Firewalld running: false"
    Nov 12 22:43:09 localhost.localdomain docker-current[13547]: time="2016-11-12T22:43:09.953737295Z" level=info msg="Loading containers: start."
    Nov 12 22:43:09 localhost.localdomain docker-current[13547]: time="2016-11-12T22:43:09.953787544Z" level=info msg="Loading containers: done."
    Nov 12 22:43:09 localhost.localdomain docker-current[13547]: time="2016-11-12T22:43:09.953795950Z" level=info msg="Daemon has completed initialization"
    Nov 12 22:43:09 localhost.localdomain docker-current[13547]: time="2016-11-12T22:43:09.953806548Z" level=info msg="Docker daemon" commit=cb079f6-unsupported execdriver=native-0.2 graphdriver=devicemapper version=1.10.3
    Nov 12 22:43:09 localhost.localdomain docker-current[13547]: time="2016-11-12T22:43:09.957962358Z" level=info msg="API listen on /var/run/docker.sock"
    Nov 12 22:43:09 localhost.localdomain systemd[1]: Started Docker Application Container Engine.

    [vagrant@localhost ~]$ docker network ls
    NETWORK ID          NAME                DRIVER
    6946ae42963c        bridge              bridge
    e1f79a5b1ddb        none                null
    f6b9fe847c0a        host                host
