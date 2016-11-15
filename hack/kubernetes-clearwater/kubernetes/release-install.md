Download, for example v1.3.7

    [vagrant@localhost ~]$ wget -c https://github.com/kubernetes/kubernetes/releases/download/v1.3.7/kubernetes.tar.gz
    --2016-11-15 10:10:01--  https://github.com/kubernetes/kubernetes/releases/download/v1.3.7/kubernetes.tar.gz
    Resolving github.com (github.com)... 192.30.253.113, 192.30.253.112
    Connecting to github.com (github.com)|192.30.253.113|:443... connected.
    HTTP request sent, awaiting response... 302 Found
    Location: https://github-cloud.s3.amazonaws.com/releases/20580498/f5d7ff58-790a-11e6-84ac-2741d0fb18f7.gz?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAISTNZFOVBIJMK3TQ%2F20161115%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20161115T101002Z&X-Amz-Expires=300&X-Amz-Signature=b7034ab7decfe8d61a88e0561a42e9ab6fd339d3027021c54b7b22f4cd3ae6e1&X-Amz-SignedHeaders=host&actor_id=0&response-content-disposition=attachment%3B%20filename%3Dkubernetes.tar.gz&response-content-type=application%2Foctet-stream [following]
    --2016-11-15 10:10:03--  https://github-cloud.s3.amazonaws.com/releases/20580498/f5d7ff58-790a-11e6-84ac-2741d0fb18f7.gz?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAISTNZFOVBIJMK3TQ%2F20161115%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20161115T101002Z&X-Amz-Expires=300&X-Amz-Signature=b7034ab7decfe8d61a88e0561a42e9ab6fd339d3027021c54b7b22f4cd3ae6e1&X-Amz-SignedHeaders=host&actor_id=0&response-content-disposition=attachment%3B%20filename%3Dkubernetes.tar.gz&response-content-type=application%2Foctet-stream
    Resolving github-cloud.s3.amazonaws.com (github-cloud.s3.amazonaws.com)... 52.216.224.232
    Connecting to github-cloud.s3.amazonaws.com (github-cloud.s3.amazonaws.com)|52.216.224.232|:443... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 1489843499 (1.4G) [application/octet-stream]
    Saving to: 鈥榢ubernetes.tar.gz鈥▒

     0% [                                       ] 12,924,489   286KB/s  eta 84m 1s

Stop legacy service instance

    [vagrant@localhost ~]$ for i in $(ls /etc/systemd/system/kube*); do svc=${i/\/etc\/systemd\/system\/}; sudo systemctl stop $svc; done

Extract

    [vagrant@localhost ~]$ tar -tzf kubernetes.tar.gz

    kubernetes/server/
    kubernetes/server/kubernetes-salt.tar.gz

    kubernetes/server/kubernetes-manifests.tar.gz

    kubernetes/server/kubernetes-server-linux-amd64.tar.gz

    [vagrant@localhost ~]$ sudo tar -C /opt -zxf kubernetes.tar.gz kubernetes/server/kubernetes-server-linux-amd64.tar.gz   

    [vagrant@localhost ~]$ cd /opt/kubernetes/

    [vagrant@localhost kubernetes]$ sudo mv server/bin 1.3.10/release

    [vagrant@localhost ~]$ sudo tar -C /opt -zxf /opt/kubernetes/server/kubernetes-server-linux-amd64.tar.gz    

Validate

    [vagrant@localhost kubernetes]$ /opt/kubernetes/server/bin/kubelet --version
    Kubernetes v1.3.7

Start fresh service instance

    [vagrant@localhost kubernetes]$ for i in $(ls /etc/systemd/system/kube*); do svc=${i/\/etc\/systemd\/system\/}; sudo systemctl start $svc; done

Important !!! to validate service running

    [vagrant@localhost kubernetes]$ sudo journalctl --no-tail --no-pager --pager-end -u kube-apiserver.service

    [vagrant@localhost kubernetes]$ sudo journalctl --no-tail --no-pager --pager-end -u kube-controller-manager.service
    E1115 11:33:42.038303   14523 controllermanager.go:253] Failed to start service controller: ServiceController should not be run without a cloudprovider.
    E1115 11:33:42.606684   14523 util.go:45] Metric for serviceaccount_controller already registered

    [vagrant@localhost kubernetes]$ sudo journalctl --no-tail --no-pager --pager-end -u kube-scheduler.service    

    [vagrant@localhost kubernetes]$ sudo journalctl --no-tail --no-pager --pager-end -u kubelet.service
    E1115 11:33:43.464190   14538 kubelet.go:954] Image garbage collection failed: unable to find data for container /
    E1115 11:33:43.628377   14538 kubelet.go:2397] Failed to check if disk space is available for the runtime: failed to get fs info for "runtime": unable to find data for container /
    E1115 11:33:43.628393   14538 kubelet.go:2405] Failed to check if disk space is available on the root partition: failed to get fs info for "root": unable to find data for container /
    E1115 11:33:43.629611   14538 manager.go:240] Registration of the rkt container factory failed: unable to communicate with Rkt api service: rkt: cannot tcp Dial rkt api service: dial tcp [::1]:15441: getsockopt: connection refused

    [vagrant@localhost kubernetes]$ sudo journalctl --no-tail --no-pager --pager-end -u kube-proxy.service

    [vagrant@localhost kubernetes]$ kubectl get ep,svc
    NAME                ENDPOINTS          AGE
    kubernetes          10.64.33.81:6443   1d
    netcat-hello-http   10.121.24.3:80     1d
    NAME                CLUSTER-IP         EXTERNAL-IP   PORT(S)   AGE
    kubernetes          10.123.240.1       <none>        443/TCP   1d
    netcat-hello-http   10.123.242.12      <none>        80/TCP    1d

    [vagrant@localhost kubernetes]$ curl 10.121.24.3
    <html><head><title>welcome</title></head><body><h1>hello world</h1></body></html>

    [vagrant@localhost kubernetes]$ curl 10.123.242.12
    <html><head><title>welcome</title></head><body><h1>hello world</h1></body></html>

    [vagrant@localhost kubernetes]$ docker push 10.64.33.81:5000/netcat-hello-http
    The push refers to a repository [10.64.33.81:5000/netcat-hello-http]
    5f70bf18a086: Layer already exists
    14996164fa4d: Layer already exists
    000ac623049f: Layer already exists
    3f50a8137adf: Layer already exists
    latest: digest: sha256:e21c11edf699f9c582b46388f269a44ee5f0662b099cca7cfd30d5c6970cf563 size: 1748
