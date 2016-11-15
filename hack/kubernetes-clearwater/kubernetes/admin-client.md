### Tables of content

* KUBECONFIG of kubectl

* Private registry of docker

Config for `kubectl`

    [vagrant@localhost ~]$ ip a show eth1
    3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
        link/ether 08:00:27:74:ca:21 brd ff:ff:ff:ff:ff:ff
        inet 10.64.33.101/24 brd 10.64.33.255 scope global eth1
           valid_lft forever preferred_lft forever
        inet6 fe80::a00:27ff:fe74:ca21/64 scope link
           valid_lft forever preferred_lft forever

    [vagrant@localhost ~]$ mkdir -p .pki/kubernetes/master81

    [vagrant@master81 ~]$ scp .kube/config vagrant@10.64.33.101:/home/vagrant/.pki/kubernetes/master81/kubeconfig
    vagrant@10.64.33.101's password:
    config                                        100%   10KB   9.9KB/s   00:00

    [vagrant@localhost ~]$ KUBECONFIG='.pki/kubernetes/master81/kubeconfig' kubectl get nodes
    NAME          STATUS    AGE
    10.64.33.81   Ready     1d

Private `registry` for `docker`

    [vagrant@localhost ~]$ KUBECONFIG='.pki/kubernetes/master81/kubeconfig' kubectl --namespace=stackdocker get pods
    NAME                        READY     STATUS    RESTARTS   AGE
    registry-2499285598-9vdxa   1/1       Running   1          15h

    [vagrant@localhost ~]$ scp vagrant@10.64.33.81:/home/vagrant/kubernetes/registry/2.4.1/tls.* .
    vagrant@10.64.33.81's password:
    tls.crt                                       100% 1285     1.3KB/s   00:00
    tls.key                                       100% 1679     1.6KB/s   00:00

    [vagrant@localhost ~]$ sudo mkdir -p /etc/docker/certs.d/10.64.33.81:5000

    [vagrant@localhost ~]$ sudo mv tls.* /etc/docker/certs.d/10.64.33.81\:5000/

    [vagrant@localhost ~]$ sudo vi /etc/sysconfig/docker
    OPTIONS='--insecure-registry=172.30.0.0/16 --insecure-registry=ci.dev.openshift.redhat.com:5000 --selinux-enabled --log-driver=journald --insecure-registry=10.128.0.0/14 --bridge=lbr0 --fixed-cidr=10.128.2.0/23 --insecure-registry=10.64.33.81:5000'

    [vagrant@localhost ~]$ sudo systemctl restart docker.service

    [vagrant@localhost ~]$ docker login -u admin -p admin123 10.64.33.81:5000
    Email:
    WARNING: login credentials saved in /home/vagrant/.docker/config.json
    Login Succeeded

    [vagrant@master81 ~]$ docker tag gcr.io/google_containers/pause-amd64:3.0 10.64.33.81:5000/google_containers_pause-amd64:3.0

    [vagrant@master81 ~]$ docker push 10.64.33.81:5000/google_containers_pause-amd64:3.0
    The push refers to a repository [10.64.33.81:5000/google_containers_pause-amd64]
    5f70bf18a086: Mounted from netcat-hello-http
    41ff149e94f2: Pushed
    3.0: digest: sha256:796bf45888b8c74ead28547f4d3c7fdcde8c898fb67ef2b279186d7d7dbf72e8 size: 917

    [vagrant@localhost ~]$ docker pull 10.64.33.81:5000/google_containers_pause-amd64:3.0
    Trying to pull repository 10.64.33.81:5000/google_containers_pause-amd64 ...
    3.0: Pulling from 10.64.33.81:5000/google_containers_pause-amd64
    a3ed95caeb02: Pull complete
    f11233434377: Pull complete
    Digest: sha256:796bf45888b8c74ead28547f4d3c7fdcde8c898fb67ef2b279186d7d7dbf72e8
    Status: Downloaded newer image for 10.64.33.81:5000/google_containers_pause-amd64:3.0

    [vagrant@localhost ~]$ docker tag 10.64.33.81:5000/google_containers_pause-amd64:3.0 gcr.io/google_containers/pause-amd64:3.0
