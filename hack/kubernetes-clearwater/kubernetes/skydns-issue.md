
To 1.3.6

    [vagrant@localhost ~]$ kubectl --namespace=kube-system get svc,rc

    [vagrant@localhost ~]$ kubectl create -f kubernetes/1.3.6/manifests/addons/dns/skydns-rc.yaml
    replicationcontroller "kube-dns-v20" created

    [vagrant@localhost ~]$ kubectl create -f kubernetes/1.3.6/manifests/addons/dns/skydns-svc.yaml
    service "kube-dns" created

    [vagrant@localhost ~]$ kubectl --namespace=kube-system get pods,ep,svc,rc
    NAME                 READY           STATUS             RESTARTS   AGE
    kube-dns-v20-qci0l   2/3             CrashLoopBackOff   4          2m
    NAME                 ENDPOINTS       AGE
    kube-dns                             2m
    NAME                 CLUSTER-IP      EXTERNAL-IP   PORT(S)         AGE
    kube-dns             10.123.240.10   <none>        53/UDP,53/TCP   2m
    NAME                 DESIRED         CURRENT       AGE
    kube-dns-v20         1               1             9m

    [vagrant@localhost ~]$ kubectl --namespace=kube-system logs kube-dns-v20-qci0l -c kubedns
    F1115 11:49:47.951866       1 server.go:55] Failed to create a kubernetes client: invalid configuration: no configuration has been provided

    [vagrant@localhost ~]$ kubectl --namespace=kube-system logs kube-dns-v20-qci0l -c dnsmasq
    dnsmasq[1]: started, version 2.76 cachesize 1000
    dnsmasq[1]: compile time options: IPv6 GNU-getopt no-DBus no-i18n no-IDN DHCP DHCPv6 no-Lua TFTP no-conntrack ipset auth no-DNSSEC loop-detect inotify
    dnsmasq[1]: using nameserver 127.0.0.1#10053
    dnsmasq[1]: failed to load names from /etc/hosts: Permission denied

    [vagrant@localhost ~]$ kubectl --namespace=kube-system logs kube-dns-v20-qci0l -c healthz
    2016/11/15 11:47:54 Healthz probe on /healthz-dnsmasq error: Result of last exec: nslookup: can't resolve 'kubernetes.default.svc.cluster.local'
    , at 2016-11-15 11:47:53.967915568 +0000 UTC, error exit status 1
    2016/11/15 11:48:04 Healthz probe on /healthz-dnsmasq error: Result of last exec: nslookup: can't resolve 'kubernetes.default.svc.cluster.local'
    , at 2016-11-15 11:48:03.966702303 +0000 UTC, error exit status 1
    2016/11/15 11:48:14 Healthz probe on /healthz-dnsmasq error: Result of last exec: nslookup: can't resolve 'kubernetes.default.svc.cluster.local'
    , at 2016-11-15 11:48:13.96200954 +0000 UTC, error exit status 1
    2016/11/15 11:48:24 Healthz probe on /healthz-dnsmasq error: Result of last exec: nslookup: can't resolve 'kubernetes.default.svc.cluster.local'
    , at 2016-11-15 11:48:23.971159243 +0000 UTC, error exit status 1
    2016/11/15 11:48:34 Healthz probe on /healthz-dnsmasq error: Result of last exec: nslookup: can't resolve 'kubernetes.default.svc.cluster.local'
    , at 2016-11-15 11:48:34.111545116 +0000 UTC, error exit status 1
    2016/11/15 11:50:04 Healthz probe on /healthz-dnsmasq error: Result of last exec: nslookup: can't resolve 'kubernetes.default.svc.cluster.local'
    , at 2016-11-15 11:50:03.961031994 +0000 UTC, error exit status 1

    [vagrant@localhost ~]$ kubectl --namespace=kube-system delete svc/kube-dns rc/kube-dns-v20
    service "kube-dns" deleted
    replicationcontroller "kube-dns-v20" deleted
