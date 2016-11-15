Instruction
------------

For `kubernetes` 1.3.6

    tangf@DESKTOP-H68OQDV ~
    $ cd /cygdrive/g/go/src/k8s.io/kubernetes/

    tangf@DESKTOP-H68OQDV /cygdrive/g/go/src/k8s.io/kubernetes
    $ git branch --all
    * master
      remotes/origin/1.3.6
      remotes/origin/1.3.7
      remotes/origin/HEAD -> origin/master

    tangf@DESKTOP-H68OQDV /cygdrive/g/go/src/k8s.io/kubernetes
    $ git checkout 1.3.6
    Checking out files: 100% (8487/8487), done.
    Branch 1.3.6 set up to track remote branch 1.3.6 from origin.
    Switched to a new branch '1.3.6'

DNS

    tangf@DESKTOP-H68OQDV /cygdrive/g/go/src/k8s.io/kubernetes
    $ mkdir -p /cygdrive/g/work/src/github.com/Metaswitch/clearwater-docker/hack/kubernetes-clearwater/kubernetes/1.3.6/manifests/addons/dns

    tangf@DESKTOP-H68OQDV /cygdrive/g/go/src/k8s.io/kubernetes
    $ sed "s/\$DNS_REPLICAS/1/g;s/\$DNS_DOMAIN/cluster.local/g" cluster/addons/dns/skydns-rc.yaml.sed >/cygdrive/g/work/src/github.com/Metaswitch/clearwater-docker/hack/kubernetes-clearwater/kubernetes/1.3.6/manifests/addons/dns/skydns-rc.yaml    

    tangf@DESKTOP-H68OQDV /cygdrive/g/go/src/k8s.io/kubernetes
    $ sed "s/\$DNS_SERVER_IP/10.123.240.10/g" cluster/addons/dns/skydns-svc.yaml.sed >/cygdrive/g/work/src/github.com/Metaswitch/clearwater-docker/hack/kubernetes-clearwater/kubernetes/1.3.6/manifests/addons/dns/skydns-svc.yaml

Dashboard

    tangf@DESKTOP-H68OQDV /cygdrive/g/go/src/k8s.io/kubernetes
    $ cp cluster/addons/dashboard/dashboard-*.yaml /cygdrive/g/work/src/github.com/Metaswitch/clearwater-docker/hack/kubernetes-clearwater/kubernetes/1.3.6/manifests/addons/dashboard/
