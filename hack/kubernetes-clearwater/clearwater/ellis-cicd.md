
### Continuously Integration

Fedora23

    [tangfx@localhost Metaswitch]$ git clone https://github.com/Metaswitch/ellis ellis
    Cloning into 'ellis'...
    remote: Counting objects: 3051, done.
    remote: Compressing objects: 100% (8/8), done.
    remote: Total 3051 (delta 2), reused 0 (delta 0), pack-reused 3043
    Receiving objects: 100% (3051/3051), 1.20 MiB | 254.00 KiB/s, done.
    Resolving deltas: 100% (1558/1558), done.
    Checking connectivity... done.
    [tangfx@localhost Metaswitch]$ ls
    clearwater-docker  ellis

    [tangfx@localhost ellis]$ git submodule init
    Submodule 'build-infra' (git@github.com:Metaswitch/clearwater-build-infra.git) registered for path 'build-infra'
    Submodule 'common' (git@github.com:Metaswitch/python-common.git) registered for path 'common'

    [tangfx@localhost ellis]$ cat .gitmodules
    [submodule "build-infra"]
            path = build-infra
            url = git@github.com:Metaswitch/clearwater-build-infra.git
    [submodule "common"]
            path = common
            url = git@github.com:Metaswitch/python-common.git

    [tangfx@localhost ellis]$ git config url."git@github.com".insteadOf "https://github.com/"

    [tangfx@localhost ellis]$ git submodule status
    -ecb9d312bf9cf92f94a6a80ea36432eb0b9decf5 build-infra
    -54613ba162d1b6b76ed2ad0aa1475d63dba18129 common

    [tangfx@localhost ellis]$ cat .gitmodules
    [submodule "build-infra"]
            path = build-infra
            url = git@github.com:Metaswitch/clearwater-build-infra.git
    [submodule "common"]
            path = common
            url = git@github.com:Metaswitch/python-common.git

    [tangfx@localhost ellis]$ git submodule add -b ecb9d312bf9cf92f94a6a80ea36432eb0b9decf5 --name clearwater-build-infra https://github.com/Metaswitch/clearwater-build-infra
    Cloning into 'clearwater-build-infra'...
    remote: Counting objects: 394, done.
    remote: Total 394 (delta 0), reused 0 (delta 0), pack-reused 394
    Receiving objects: 100% (394/394), 105.55 KiB | 59.00 KiB/s, done.
    Resolving deltas: 100% (178/178), done.
    Checking connectivity... done.
    fatal: Cannot update paths and switch to branch 'ecb9d312bf9cf92f94a6a80ea36432eb0b9decf5' at the same time.
    Did you intend to checkout 'origin/ecb9d312bf9cf92f94a6a80ea36432eb0b9decf5' which can not be resolved as commit?
    Unable to checkout submodule 'clearwater-build-infra'

    [tangfx@localhost ellis]$ git submodule add --name clearwater-build-infra https://github.com/Metaswitch/clearwater-build-infra                                  
    Adding existing repo at 'clearwater-build-infra' to the index

    [tangfx@localhost ellis]$ cd clearwater-build-infra/

    [tangfx@localhost clearwater-build-infra]$ git checkout

    [tangfx@localhost ellis]$ git submodule add --name python-common https://github.com/Metaswitch/python-common python-common                                      Cloning into 'python-common'...
    remote: Counting objects: 1067, done.
    remote: Compressing objects: 100% (8/8), done.
    remote: Total 1067 (delta 3), reused 0 (delta 0), pack-reused 1059
    Receiving objects: 100% (1067/1067), 175.80 KiB | 62.00 KiB/s, done.
    Resolving deltas: 100% (616/616), done.
    Checking connectivity... done.

    [tangfx@localhost ellis]$ cd ..

    [tangfx@localhost Metaswitch]$ git clone https://github.com/Metaswitch/clearwater-build-infra.git clearwater-build-infra
    Cloning into 'clearwater-build-infra'...
    remote: Counting objects: 394, done.
    remote: Total 394 (delta 0), reused 0 (delta 0), pack-reused 394
    Receiving objects: 100% (394/394), 105.55 KiB | 27.00 KiB/s, done.
    Resolving deltas: 100% (178/178), done.
    Checking connectivity... done.

    [tangfx@localhost Metaswitch]$ git clone https://github.com/Metaswitch/python-common.git python-common
    Cloning into 'python-common'...
    remote: Counting objects: 1067, done.
    remote: Compressing objects: 100% (8/8), done.
    remote: Total 1067 (delta 3), reused 0 (delta 0), pack-reused 1059
    Receiving objects: 100% (1067/1067), 175.80 KiB | 39.00 KiB/s, done.
    Resolving deltas: 100% (616/616), done.
    Checking connectivity... done.

    [tangfx@localhost Metaswitch]$ git clone https://github.com/Metaswitch/cpp-common cpp-common
    Cloning into 'cpp-common'...
    remote: Counting objects: 8746, done.
    remote: Compressing objects: 100% (43/43), done.
    remote: Total 8746 (delta 24), reused 0 (delta 0), pack-reused 8703
    Receiving objects: 100% (8746/8746), 2.32 MiB | 440.00 KiB/s, done.
    Resolving deltas: 100% (6101/6101), done.
    Checking connectivity... done.

    [tangfx@localhost ellis]$ cd ../clearwater-build-infra/

    [tangfx@localhost clearwater-build-infra]$ git checkout ecb9d31
    Note: checking out 'ecb9d31'.

    [tangfx@localhost clearwater-build-infra]$ cd ../python-common/
    [tangfx@localhost python-common]$ git checkout 54613ba

    [tangfx@localhost python-common]$ cd ../cpp-common/

    [tangfx@localhost cpp-common]$ git checkout 87318a3
    Note: checking out '87318a3'.

    [tangfx@localhost ellis]$ cp ../clearwater-build-infra/* build-infra/

    [tangfx@localhost ellis]$ cp -r ../python-common/* common/

    [tangfx@localhost Metaswitch]$ python --version
    Python 2.7.11

    [tangfx@localhost Metaswitch]$ gcc --version
    gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
    Copyright (C) 2015 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

    [tangfx@localhost Metaswitch]$ sudo dnf groupinstall "Development Tools"

    [tangfx@localhost Metaswitch]$ sudo dnf install python-devel
    Last metadata expiration check: 0:04:45 ago on Wed Nov 16 03:02:51 2016.
    Dependencies resolved.
    ================================================================================
     Package                  Arch         Version              Repository     Size
    ================================================================================
    Installing:
     python-devel             x86_64       2.7.11-11.fc23       updates       398 k
     python-rpm-macros        noarch       3-7.fc23             updates       8.8 k
     python2-rpm-macros       noarch       3-7.fc23             updates       8.2 k

    Transaction Summary
    ================================================================================
    Install  3 Packages

    Total download size: 415 k
    Installed size: 1.1 M
    Is this ok [y/N]: y
    Downloading Packages:
    (1/3): python2-rpm-macros-3-7.fc23.noarch.rpm    25 kB/s | 8.2 kB     00:00
    (2/3): python-rpm-macros-3-7.fc23.noarch.rpm     26 kB/s | 8.8 kB     00:00
    (3/3): python-devel-2.7.11-11.fc23.x86_64.rpm   756 kB/s | 398 kB     00:00
    --------------------------------------------------------------------------------
    Total                                           101 kB/s | 415 kB     00:04
    Running transaction check
    Transaction check succeeded.
    Running transaction test
    Transaction test succeeded.
    Running transaction
      Installing  : python2-rpm-macros-3-7.fc23.noarch                          1/3
      Installing  : python-rpm-macros-3-7.fc23.noarch                           2/3
      Installing  : python-devel-2.7.11-11.fc23.x86_64                          3/3
      Verifying   : python-devel-2.7.11-11.fc23.x86_64                          1/3
      Verifying   : python-rpm-macros-3-7.fc23.noarch                           2/3
      Verifying   : python2-rpm-macros-3-7.fc23.noarch                          3/3

    Installed:
      python-devel.x86_64 2.7.11-11.fc23      python-rpm-macros.noarch 3-7.fc23
      python2-rpm-macros.noarch 3-7.fc23

    Complete!


    [tangfx@localhost ellis]$ sudo pip --trusted-host=mirrors.aliyun.com install --index-url=http://mirrors.aliyun.com/pypi/simple/ virtualenv
    You are using pip version 7.1.0, however version 9.0.1 is available.
    You should consider upgrading via the 'pip install --upgrade pip' command.
    Collecting virtualenv
      Downloading http://mirrors.aliyun.com/pypi/packages/45/9c/acd0645222dc9f3593e86a33b3e5cae0be841c04807bf0f183625bc5fe85/virtualenv-15.0.3-py2.py3-none-any.whl (3.5MB)

    Refernece

        https://pypi-mirrors.org/

    [tangfx@localhost ellis]$ mkdir -p ~/.pip

    [tangfx@localhost ellis]$ vi ~/.pip/pip.conf

    [tangfx@localhost ellis]$ virtualenv _env
    New python executable in /go/src/github.com/Metaswitch/ellis/_env/bin/python
    Installing setuptools, pip, wheel...done.


    [tangfx@localhost ellis]$ sudo dnf install redhat-rpm-config
    Last metadata expiration check: 2:34:49 ago on Wed Nov 16 03:02:51 2016.
    Dependencies resolved.
    ================================================================================
     Package                  Arch         Version              Repository     Size
    ================================================================================
    Installing:
     dwz                      x86_64       0.12-1.fc23          fedora        106 k
     fpc-srpm-macros          noarch       1.0-1.fc23           updates       7.8 k
     ghc-srpm-macros          noarch       1.4.2-2.fc23         fedora        8.2 k
     gnat-srpm-macros         noarch       2-1.fc23             fedora        8.4 k
     go-srpm-macros           noarch       2-3.fc23             fedora        8.0 k
     ocaml-srpm-macros        noarch       2-3.fc23             fedora        8.1 k
     perl-srpm-macros         noarch       1-17.fc23            fedora        9.7 k
     python-srpm-macros       noarch       3-7.fc23             updates       8.1 k
     redhat-rpm-config        noarch       37-1.fc23.1          updates        59 k

    Transaction Summary
    ================================================================================
    Install  9 Packages

    [tangfx@localhost ellis]$ sudo dnf install libcurl-devel
    Last metadata expiration check: 2:42:31 ago on Wed Nov 16 03:02:51 2016.
    Dependencies resolved.
    ================================================================================
     Package              Arch          Version                Repository      Size
    ================================================================================
    Installing:
     libcurl-devel        x86_64        7.43.0-10.fc23         updates        591 k

    Transaction Summary
    ================================================================================
    Install  1 Package

    [tangfx@localhost ellis]$ sudo dnf install python-mysql
    Last metadata expiration check: 2:49:54 ago on Wed Nov 16 03:02:51 2016.
    Dependencies resolved.
    ================================================================================
     Package              Arch         Version                  Repository     Size
    ================================================================================
    Installing:
     mariadb-common       x86_64       1:10.0.27-1.fc23         updates        75 k
     mariadb-config       x86_64       1:10.0.27-1.fc23         updates        26 k
     mariadb-libs         x86_64       1:10.0.27-1.fc23         updates       638 k
     python-mysql         x86_64       1.3.6-4.fc23             fedora         98 k

    Transaction Summary
    ================================================================================
    Install  4 Packages

    [tangfx@localhost ellis]$ sudo dnf install mysql-devel
    Last metadata expiration check: 2:51:01 ago on Wed Nov 16 03:02:51 2016.
    Dependencies resolved.
    ================================================================================
     Package                  Arch        Version                Repository    Size
    ================================================================================
    Installing:
     keyutils-libs-devel      x86_64      1.5.9-7.fc23           fedora        45 k
     krb5-devel               x86_64      1.14.3-8.fc23          updates      667 k
     libcom_err-devel         x86_64      1.42.13-3.fc23         fedora        35 k
     libselinux-devel         x86_64      2.4-4.fc23             fedora       182 k
     libsepol-devel           x86_64      2.4-1.fc23             fedora        77 k
     libverto-devel           x86_64      0.2.6-5.fc23           fedora        16 k
     mariadb-devel            x86_64      1:10.0.27-1.fc23       updates      870 k
     openssl-devel            x86_64      1:1.0.2j-1.fc23        updates      1.5 M
     pcre-devel               x86_64      8.39-6.fc23            updates      542 k
     zlib-devel               x86_64      1.2.8-9.fc23           fedora        55 k
    Upgrading:
     pcre                     x86_64      8.39-6.fc23            updates      506 k

    Transaction Summary
    ================================================================================
    Install  10 Packages
    Upgrade   1 Package

    [tangfx@localhost ellis]$ sudo dnf install libffi-devel
    Last metadata expiration check: 2:59:14 ago on Wed Nov 16 03:02:51 2016.
    Dependencies resolved.
    ================================================================================
     Package              Arch           Version               Repository      Size
    ================================================================================
    Installing:
     libffi-devel         x86_64         3.1-8.fc23            fedora          27 k

    Transaction Summary
    ================================================================================
    Install  1 Package

    [tangfx@localhost ellis]$ sudo dnf install zeromq-devel
    Last metadata expiration check: 0:02:24 ago on Wed Nov 16 06:04:05 2016.
    Dependencies resolved.
    ================================================================================
     Package              Arch           Version              Repository       Size
    ================================================================================
    Installing:
     libsodium            x86_64         1.0.5-1.fc23         updates         144 k
     zeromq               x86_64         4.1.2-1.fc23         fedora          533 k
     zeromq-devel         x86_64         4.1.2-1.fc23         fedora          119 k

    Transaction Summary
    ================================================================================
    Install  3 Packages

    [tangfx@localhost ellis]$ make env
    # Set up a fresh virtual environment
    virtualenv --setuptools --python=/usr/bin/python /go/src/github.com/Metaswitch/ellis/_env
    Already using interpreter /usr/bin/python
    New python executable in /go/src/github.com/Metaswitch/ellis/_env/bin/python
    Installing setuptools, pip, wheel...done.
    /go/src/github.com/Metaswitch/ellis/_env/bin/easy_install "setuptools>0.7"
    Searching for setuptools>0.7
    Best match: setuptools 28.8.0
    Adding setuptools 28.8.0 to easy-install.pth file
    Installing easy_install-3.5 script to /go/src/github.com/Metaswitch/ellis/_env/bin
    Installing easy_install script to /go/src/github.com/Metaswitch/ellis/_env/bin

    Using /go/src/github.com/Metaswitch/ellis/_env/lib/python2.7/site-packages


    # Touch the sentinel file
    touch /go/src/github.com/Metaswitch/ellis/_env/.eggs_installed

    [tangfx@localhost ellis]$ ls  /go/src/github.com/Metaswitch/ellis/_env/lib/python2.7/site-packages
    cffi-1.5.2-py2.7-linux-x86_64.egg
    distribute-0.7.3-py2.7.egg
    easy-install.pth
    easy_install.py
    easy_install.pyc
    ellis-0.1-py2.7.egg
    metaswitchcommon-0.1-py2.7-linux-x86_64.egg
    monotonic-0.6-py2.7.egg
    msgpack_python-0.4.6-py2.7-linux-x86_64.egg
    MySQL_python-1.2.5-py2.7-linux-x86_64.egg
    phonenumbers-7.1.1-py2.7.egg
    pip
    pip-9.0.1.dist-info
    pkg_resources
    prctl-1.0.1-py2.7-linux-x86_64.egg
    py_bcrypt-0.4-py2.7-linux-x86_64.egg
    pycparser-2.17-py2.7.egg
    pycrypto-2.6.1-py2.7-linux-x86_64.egg
    pycurl-7.43.0-py2.7-linux-x86_64.egg
    pyzmq-15.2.0-py2.7-linux-x86_64.egg
    setuptools
    setuptools-28.8.0.dist-info
    setuptools.pth
    SQLAlchemy-1.0.9-py2.7-linux-x86_64.egg
    tornado-2.3-py2.7.egg
    wheel
    wheel-0.30.0a0.dist-info

Jessie

    [tangfx@localhost ellis]$ docker pull docker.io/python:2.7.12-onbuild
    Trying to pull repository docker.io/library/python ...
    2.7.12-onbuild: Pulling from docker.io/library/python
    386a066cd84a: Pull complete
    75ea84187083: Pull complete
    88b459c9f665: Pull complete
    1e3ee139a577: Pull complete
    729baab2cba2: Pull complete
    be05488256c3: Pull complete
    6721fa748dcf: Pull complete
    303d26ecab72: Pull complete
    Digest: sha256:c0b76e670ea55f326878ac0d7cdd2509d26af3094d55c6b8d2bd8b677ed957e4
    Status: Downloaded newer image for docker.io/python:2.7.12-onbuild
