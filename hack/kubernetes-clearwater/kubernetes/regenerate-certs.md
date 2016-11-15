* Prerequsites

You have followed with above `kubernetes-installation` to create *KUBECONFIG*

Stop legacy service instances

    [vagrant@master81 ~]$ for i in $(ls /etc/systemd/system/kube*); do svc=${i/\/etc\/systemd\/system\/}; sudo systemctl stop $svc; done

* Certs and KUBECONFIG

Generate certs

    [vagrant@master81 ~]$ vi salt-make-ca-cert.sh

    [vagrant@master81 ~]$ ./salt-make-ca-cert.sh
    IP:10.64.33.81,IP:10.123.240.1,DNS:kubernetes,DNS:kubernetes.default,DNS:kubernetes.default.svc,DNS:kubernetes.default.svc.cluster.local
    Generate ca certs into /home/vagrant

    [vagrant@master81 ~]$ ls
    bin         kube         kubecfg.key  kubernetes.tar.gz     server.cert
    ca.crt      kubecfg.crt  kubernetes   salt-make-ca-cert.sh  server.key

    [vagrant@master81 ~]$ sudo cp ca.crt kubecfg.crt kubecfg.key server.cert server.key /srv/kubernetes/

Update `KUBECONFIG`

    [vagrant@master81 ~]$ encoded=$(sudo base64 -w0 /srv/kubernetes/ca.crt); kubectl config set clusters.kube.certificate-authority-data "$encoded"

    [vagrant@master81 ~]$ encoded=$(sudo base64 -w0 /srv/kubernetes/kubecfg.crt); kubectl config set users.admin.client-certificate-data "$encoded"

    [vagrant@master81 ~]$ encoded=$(sudo base64 -w0 /srv/kubernetes/kubecfg.key); kubectl config set users.admin.client-key-data "$encoded"

    [vagrant@master81 ~]$ sudo cp .kube/config /srv/kubernetes/kubeconfig

Remove legacy DB

    [vagrant@master81 ~]$ etcdctl ls --recursive /registry/secrets
    /registry/secrets/default
    /registry/secrets/default/default-token-hs193
    /registry/secrets/kube-system
    /registry/secrets/kube-system/default-token-6tjce
    /registry/secrets/stackdocker
    /registry/secrets/stackdocker/registry-tls
    /registry/secrets/stackdocker/default-token-zr7w0
    /registry/secrets/stackdocker/registry-htpasswd

    [vagrant@master81 ~]$ etcdctl rm --recursive /registry/secrets/kube-system
    [vagrant@master81 ~]$ etcdctl rm --recursive /registry/secrets/default
    [vagrant@master81 ~]$ etcdctl rm /registry/secrets/stackdocker/default-token-zr7w0

Start service

    [vagrant@master81 ~]$ for i in $(ls /etc/systemd/system/kube*); do svc=${i/\/etc\/systemd\/system\/}; sudo systemctl start $svc; done

Important !!! validate

    [vagrant@master81 ~]$ sudo journalctl --no-pager --pager-end --no-tail --unit=kube-apiserver.service

    [vagrant@master81 ~]$ sudo journalctl --no-pager --pager-end --no-tail --unit=kube-controller-manager.service

    [vagrant@master81 ~]$ sudo journalctl --no-pager --pager-end --no-tail --unit=kube-scheduler.service

    [vagrant@master81 ~]$ sudo journalctl --no-pager --pager-end --no-tail --unit=kubelet.service

    [vagrant@master81 ~]$ sudo journalctl --no-pager --pager-end --no-tail --unit=kube-proxy.service

    [vagrant@master81 ~]$ kubectl get all --all-namespaces
    NAMESPACE     NAME                                DESIRED         CURRENT            AGE
    kube-system   kubernetes-dashboard-v1.4.0         1               1                  1h
    NAMESPACE     NAME                                CLUSTER-IP      EXTERNAL-IP        PORT(S)    AGE
    default       kubernetes                          10.123.240.1    <none>             443/TCP    1d
    default       netcat-hello-http                   10.123.242.12   <none>             80/TCP     1d
    stackdocker   registry                            10.123.240.35   <none>             5000/TCP   17h
    NAMESPACE     NAME                                READY           STATUS             RESTARTS   AGE
    default       netcat-hello-http-839099240-j628h   1/1             Running            9          1d
    kube-system   kubernetes-dashboard-v1.4.0-akswj   0/1             CrashLoopBackOff   15         1h
    stackdocker   registry-2499285598-9vdxa           1/1             Running            1          17h

Important !!! update node and client with newest certs and kubeconfig

    [vagrant@localhost ~]$ scp 10.64.33.81:/home/vagrant/.kube/config .pki/kubernetes/master81/kubeconfig
    vagrant@10.64.33.81's password:
    config                                        100%   10KB   9.9KB/s   00:00
