Tables of content
------------------

Download release

    [vagrant@localhost ~]$ wget -c https://github.com/kubernetes/kubernetes/releases/download/v1.3.10/kubernetes.tar.gz
    --2016-11-11 01:58:59--  https://github.com/kubernetes/kubernetes/releases/download/v1.3.10/kubernetes.tar.gz
    Resolving github.com (github.com)... 192.30.253.113, 192.30.253.112
    Connecting to github.com (github.com)|192.30.253.113|:443... connected.
    HTTP request sent, awaiting response... 302 Found
    Location: https://github-cloud.s3.amazonaws.com/releases/20580498/b73a52cc-9f80-11e6-8085-e5bdc11f8bd8.gz?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAISTNZFOVBIJMK3TQ%2F20161111%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20161111T015900Z&X-Amz-Expires=300&X-Amz-Signature=77d9df5701f07bd4922654ac7aad99ba4a1aa65d32c2cc8c258170b710511645&X-Amz-SignedHeaders=host&actor_id=0&response-content-disposition=attachment%3B%20filename%3Dkubernetes.tar.gz&response-content-type=application%2Foctet-stream [following]
    --2016-11-11 01:59:00--  https://github-cloud.s3.amazonaws.com/releases/20580498/b73a52cc-9f80-11e6-8085-e5bdc11f8bd8.gz?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAISTNZFOVBIJMK3TQ%2F20161111%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20161111T015900Z&X-Amz-Expires=300&X-Amz-Signature=77d9df5701f07bd4922654ac7aad99ba4a1aa65d32c2cc8c258170b710511645&X-Amz-SignedHeaders=host&actor_id=0&response-content-disposition=attachment%3B%20filename%3Dkubernetes.tar.gz&response-content-type=application%2Foctet-stream
    Resolving github-cloud.s3.amazonaws.com (github-cloud.s3.amazonaws.com)... 52.216.0.128
    Connecting to github-cloud.s3.amazonaws.com (github-cloud.s3.amazonaws.com)|52.216.0.128|:443... connected.
    HTTP request sent, awaiting response... 206 Partial Content
    Length: 1495467451 (1.4G), 1495466858 (1.4G) remaining [application/octet-stream]
    Saving to: 鈥榢ubernetes.tar.gz鈥▒

    27% [=========>                             ] 405,582,941 3.21MB/s  eta 8m 34s

    [vagrant@localhost ~]$ sudo tar -C /opt -zxf kubernetes.tar.gz kubernetes/server/kubernetes-server-linux-amd64.tar.gz

    [vagrant@localhost ~]$ sudo tar -tzf /opt/kubernetes/server/kubernetes-server-linux-amd64.tar.gz
    kubernetes/
    kubernetes/addons/
    kubernetes/kubernetes-src.tar.gz
    kubernetes/server/
    kubernetes/server/bin/
    kubernetes/server/bin/kube-proxy.tar
    kubernetes/server/bin/kube-controller-manager
    kubernetes/server/bin/kube-proxy.docker_tag
    kubernetes/server/bin/federation-apiserver.docker_tag
    kubernetes/server/bin/federation-controller-manager.docker_tag
    kubernetes/server/bin/kube-scheduler
    kubernetes/server/bin/kube-scheduler.docker_tag
    kubernetes/server/bin/kube-controller-manager.tar
    kubernetes/server/bin/kubectl
    kubernetes/server/bin/kube-apiserver.docker_tag
    kubernetes/server/bin/federation-apiserver.tar
    kubernetes/server/bin/kube-apiserver.tar
    kubernetes/server/bin/federation-controller-manager.tar
    kubernetes/server/bin/federation-apiserver
    kubernetes/server/bin/kube-dns
    kubernetes/server/bin/kubemark
    kubernetes/server/bin/kubelet
    kubernetes/server/bin/kube-proxy
    kubernetes/server/bin/kube-scheduler.tar
    kubernetes/server/bin/kube-apiserver
    kubernetes/server/bin/kube-controller-manager.docker_tag
    kubernetes/server/bin/federation-controller-manager
    kubernetes/server/bin/hyperkube
    kubernetes/LICENSES

    [vagrant@localhost ~]$ sudo tar -C /opt -zxf /opt/kubernetes/server/kubernetes-server-linux-amd64.tar.gz

    [vagrant@localhost ~]$ sudo ls /opt/kubernetes/
    1.3.10  addons  kubernetes-src.tar.gz  LICENSES  server


### Build (for development option)

使用git

    [tangfx@localhost k8s.io]$ git clone https://github.com/tangfeixiong/kubernetes kubernetes
    Cloning into 'kubernetes'...
    remote: Counting objects: 337701, done.
    remote: Compressing objects: 100% (5/5), done.
    Receiving objects:  19% (65526/337701), 72.23 MiB | 127.00 KiB/s

    [tangfx@localhost k8s.io]$ git remote add upstream https://github.com/kubernetes/kubernetes

    [tangfx@localhost k8s.io]$ git pull upstream

    [tangfx@localhost kubernetes]$ git tag --list

使用v1.3.10

    [tangfx@localhost kubernetes]$ git checkout v1.3.10
    Note: checking out 'v1.3.10'.

    You are in 'detached HEAD' state. You can look around, make experimental
    changes and commit them, and you can discard any commits you make in this
    state without impacting any branches by performing another checkout.

    If you want to create a new branch to retain commits you create, you may
    do so (now or later) by using -b with the checkout command again. Example:

      git checkout -b <new-branch-name>

    HEAD is now at c3e367e... Kubernetes version v1.3.10

    [tangfx@localhost kubernetes]$ git status
    HEAD detached at v1.3.10
    nothing to commit, working directory clean

Make

    [tangfx@localhost kubernetes]$ go version
    go version go1.6.2 linux/amd64

    [tangfx@localhost kubernetes]$ make all GOFLAGS=-v
    hack/build-go.sh
    Go version: go version go1.6.2 linux/amd64
    +++ [1109 15:43:03] Building the toolchain targets:
        k8s.io/kubernetes/hack/cmd/teststale
    k8s.io/kubernetes/vendor/github.com/golang/glog
    k8s.io/kubernetes/hack/cmd/teststale
    +++ [1109 15:43:05] Building go targets for linux/amd64:
        cmd/kube-dns
        cmd/kube-proxy
        cmd/kube-apiserver
        cmd/kube-controller-manager
        cmd/kubelet
        cmd/kubemark
        cmd/hyperkube
        federation/cmd/federation-apiserver
        federation/cmd/federation-controller-manager
        plugin/cmd/kube-scheduler
        cmd/kubectl
        cmd/integration
        cmd/gendocs
        cmd/genkubedocs
        cmd/genman
        cmd/genyaml
        cmd/mungedocs
        cmd/genswaggertypedocs
        cmd/linkcheck
        examples/k8petstore/web-server/src
        federation/cmd/genfeddocs
        vendor/github.com/onsi/ginkgo/ginkgo
        test/e2e/e2e.test
        test/e2e_node/e2e_node.test
    +++ [1109 15:43:05] +++ Warning: stdlib pkg with cgo flag not found.
    +++ [1109 15:43:05] +++ Warning: stdlib pkg cannot be rebuilt since /usr/local/go/pkg is not writable by tangfx
    +++ [1109 15:43:05] +++ Warning: Make /usr/local/go/pkg writable for tangfx for a one-time stdlib install, Or
    +++ [1109 15:43:05] +++ Warning: Rebuild stdlib using the command 'CGO_ENABLED=0 go install -a -installsuffix cgo std'
    +++ [1109 15:43:05] +++ Falling back to go build, which is slower
    **********************
    +++ [1109 15:41:00] Placing binaries

    [vagrant@localhost kubernetes]$ ls _output/bin/
    conversion-gen                 integration
    deepcopy-gen                   kube-apiserver
    defaulter-gen                  kube-controller-manager
    e2e_node.test                  kubectl
    e2e.test                       kube-dns
    federation-apiserver           kubelet
    federation-controller-manager  kubemark
    gendocs                        kube-proxy
    genfeddocs                     kube-scheduler
    genkubedocs                    linkcheck
    genman                         mungedocs
    genswaggertypedocs             openapi-gen
    genyaml                        src
    ginkgo                         teststale
    hyperkube

    [vagrant@localhost kubernetes]$ _output/bin/kubelet --version
    Kubernetes v1.3.10-dirty

    [vagrant@localhost kubernetes]$ _output/bin/kubectl version --client
    Client Version: version.Info{Major:"1", Minor:"3+", GitVersion:"v1.3.10-dirty", GitCommit:"c3e367ec9eae7338ac4e2a57f293634891319b7c", GitTreeState:"dirty", BuildDate:"2016-11-09T15:11:23Z", GoVersion:"go1.6.2", Compiler:"gc", Platform:"linux/amd64"}

* Place binaries

For continuously integration

    [vagrant@localhost ~]$ mkdir bin

    [vagrant@localhost ~]$ ln -s /opt/kubernetes/1.3.10/{kubectl,kubelet,kube-apiserver,kube-controller-manager,kube-scheduler,kube-proxy,hyperkube} bin

### Create/Update Kubernetes CA and Certs

Using [saltbase make-ca-cert.sh](https://github.com/kubernetes/kubernetes/tree/master/cluster/saltbase/salt/generate-cert)

easy-rsa reference => https://github.com/OpenVPN/easy-rsa

    [vagrant@localhost ~]$ ls . kube
    .:
    bin  kube  kubernetes  salt-make-ca-cert.sh

    kube:
    easy-rsa.tar.gz

    [vagrant@localhost ~]$ ./salt-make-ca-cert.sh
    IP:10.64.33.81,IP:10.123.240.1,DNS:kubernetes,DNS:kubernetes.default,DNS:kubernetes.default.svc,DNS:kubernetes.default.svc.cluster.local
    Create ca certs into /srv/kubernetes

    [vagrant@localhost ~]$ ls /srv/kubernetes
    ca.crt  kubecfg.crt  kubecfg.key  server.cert  server.key

### Systemd service

* Run all as systemd services

Reference

    https://github.com/kubernetes/kubernetes/tree/master/cluster/centos/master/scripts


* The kube-apiserver

Service and env file

    [vagrant@localhost ~]$ vi kubernetes/1.3.10/centos/systemd/kube-apiserver.service
    [Unit]
    Description=Kubernetes API server
    Documentation=https://github.com/kubernetes/kubernetes
    After=etcd.service
    # Requires=
    # Wants=
    # Conflicts=openshift-master.service

    [Service]
    Type=notify
    User=root

    Environment=KUBERNETES_RELEASE_VERSION=1.3.10
    EnvironmentFile=/etc/sysconfig/kube-apiserver

    WorkingDirectory=/opt/kubernetes

    ExecStart=/opt/kubernetes/1.3.10/kube-apiserver KUBE_APISERVER_OPTS

    Restart=on-failure

    [Install]
    WantedBy=multi-user.target

    [vagrant@localhost ~]$ vi kubernetes/1.3.10/centos/systemd/conf/kube-apiserver

    # KUBE_APISERVER_VERSION=1.3.10

    HOSTNAME_OVERRIDE=10.64.33.81

    # --admission-control=NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,ResourceQuota

    # --advertise-address=<nil>: IP address to advertise the apiserver to members of the cluster, must be reachable by the cluster
    ADVERTISE_APISERVER=10.64.33.81

    # --cert-dir="/var/run/kubernetes"
    CA_CERTS=/srv/kubernetes

    # --enable-swagger-ui[=false]: Enables swagger ui at /swagger-ui
    SWAGGER_UI=false

    # --etcd-servers=: comma separated etcd servers to connect (http://ip:port)
    ETCD_ENDPOINTS=http://10.64.33.81:2379

    # --master-service-namespace="default": in which the kubernetes master services should be injected into pods

    # --runtime-config=: A set of key=value pairs such as apis/<groupVersion>=true/false, also  apis/<groupVersion>/<resource>
    RUNTIME_CONFIG=api/all=true

    # --secure-port=6443: The port on which to serve HTTPS
    SECURE_PORT=6443

    # --service-cluster-ip-range=<nil>: A CIDR notation IP range
    # Same as GKE, cluster CIDR: 10.120.0.0/14, service CIDR: 10.123.240.0/20
    SERVICE_CIDR=10.123.240.0/20
    # SERVICE_MASTER=10.123.240.1
    # SERVICE_DNS=10.123.240.10

    # --service-node-port-range=: default '30000-32767'

    KUBE_APISERVER_OPTS="--admission-control=AlwaysAdmit \
      --advertise-address=10.64.33.81 \
      --allow-privileged=true \
      --apiserver-count=1 \
      --bind-address=0.0.0.0 \
      --cert-dir=/srv/kubernetes \
      --client-ca-file=/srv/kubernetes/ca.crt \
      --enable-swagger-ui=false \
      --etcd-servers=http://10.64.33.81:2379 \
      --insecure-bind-address=127.0.0.1 \
      --insecure-port=8080 \
      --master-service-namespace=default \
      --runtime-config=api/all=true \
      --secure-port=6443 \
      --service-cluster-ip-range=10.123.240.0/20 \
      --tls-cert-file=/srv/kubernetes/server.crt \
      --tls-private-key-file=/srv/kubernetes/server.key \
      --v=2"

Manually install (with bugfix)

    [vagrant@localhost ~]$ sudo cp kubernetes/1.3.10/centos/systemd/conf/kube-apiserver  /etc/sysconfig/

    [vagrant@localhost ~]$ sudo cp kubernetes/1.3.10/centos/systemd/system/kube-apiserver.service  /etc/systemd/system

    [vagrant@localhost ~]$ sudo systemctl enable kube-apiserver.service
    Created symlink from /etc/systemd/system/multi-user.target.wants/kube-apiserver.service to /etc/systemd/system/kube-apiserver.service.

    [vagrant@localhost ~]$ sudo systemctl start kube-apiserver.service
    Job for kube-apiserver.service failed because the control process exited with error code. See "systemctl status kube-apiserver.service" and "journalctl -xe" for details.

    [vagrant@localhost ~]$ sudo tail -100 /var/log/messages
    Nov 10 21:05:28 localhost systemd: kube-apiserver.service holdoff time over, scheduling restart.
    Nov 10 21:05:28 localhost systemd: Ignoring invalid environment assignment 'KUBE_APISERVER_OPT=--admission-control=AlwaysAdmit \
    Nov 10 21:05:28 localhost systemd:  --advertise-address=$ADVERTISE_APISERVER \
    Nov 10 21:05:28 localhost systemd:  --allow-privileged=true \
    Nov 10 21:05:28 localhost systemd:  --apiserver-count=1 \
    Nov 10 21:05:28 localhost systemd:  --bind-address=0.0.0.0 \
    Nov 10 21:05:28 localhost systemd:  --cert-dir=$CA_CERTS \
    Nov 10 21:05:28 localhost systemd:  --cloud-config="" \
    Nov 10 21:05:28 localhost systemd:  --cloud-provider="" \
    Nov 10 21:05:28 localhost systemd:  --enable-swagger-ui=$SWAGGER_UI \
    Nov 10 21:05:28 localhost systemd:  --etcd-servers=${ETCD_ENDPOINTS} \
    Nov 10 21:05:28 localhost systemd:  --insecure-bind-address=127.0.0.1 \
    Nov 10 21:05:28 localhost systemd:  --insecure-port=8080 \
    Nov 10 21:05:28 localhost systemd:  --master-service-namespace=default \
    Nov 10 21:05:28 localhost systemd:  --runtime-config=$RUNTIME_CONFIG \
    Nov 10 21:05:28 localhost systemd:  --secure-port=$SECURE_PORT \
    Nov 10 21:05:28 localhost systemd:  --service-cluster-ip-range=${SERVICE_CIDR} \
    Nov 10 21:05:28 localhost systemd:  --v=2 ': /etc/sysconfig/kube-apiserver
    Nov 10 21:05:28 localhost systemd: Starting Kubernetes API server...
    Nov 10 21:05:28 localhost systemd: Failed at step EXEC spawning /opt/kubernetes/${KUBERNETES_RELEASE_VERSION}/kube-apiserver: No such file or directory
    Nov 10 21:05:28 localhost systemd: kube-apiserver.service: main process exited, code=exited, status=203/EXEC
    Nov 10 21:05:28 localhost systemd: Failed to start Kubernetes API server.
    Nov 10 21:05:28 localhost systemd: Unit kube-apiserver.service entered failed state.
    Nov 10 21:05:28 localhost systemd: kube-apiserver.service failed.
    Nov 10 21:05:28 localhost systemd: kube-apiserver.service holdoff time over, scheduling restart.
    Nov 10 21:05:28 localhost systemd: start request repeated too quickly for kube-apiserver.service
    Nov 10 21:05:28 localhost systemd: Failed to start Kubernetes API server.
    Nov 10 21:05:28 localhost systemd: Unit kube-apiserver.service entered failed state.
    Nov 10 21:05:28 localhost systemd: kube-apiserver.service failed.

    [vagrant@localhost ~]$ sudo systemctl stop kube-apiserver.service

    [vagrant@localhost ~]$ sudo systemctl daemon-reload

    [vagrant@localhost ~]$ sudo systemctl restart kube-apiserver

    [vagrant@localhost ~]$ sudo systemctl -l status kube-apiserver
    鈼▒ kube-apiserver.service - Kubernetes API server
       Loaded: loaded (/etc/systemd/system/kube-apiserver.service; enabled; vendor preset: disabled)
       Active: active (running) since Thu 2016-11-10 22:43:54 UTC; 19s ago
         Docs: https://github.com/kubernetes/kubernetes
     Main PID: 5842 (kube-apiserver)
       CGroup: /system.slice/kube-apiserver.service
               鈹斺攢5842 /opt/kubernetes/1.3.10/kube-apiserver --admission-control=AlwaysAdmit --advertise-address=10.64.33.81 --allow-privileged=true --apiserver-count=1 --bind-address=0.0.0.0 --cert-dir=/srv/kubernetes --client-ca-file=/srv/kubernetes/ca.crt --enable-swagger-ui=false --etcd-servers=http://10.64.33.81:2379 --insecure-bind-address=127.0.0.1 --insecure-port=8080 --master-service-namespace=default --runtime-config=api/all=true --secure-port=6443 --service-cluster-ip-range=10.123.240.0/20 --tls-cert-file=/srv/kubernetes/server.cert --tls-private-key-file=/srv/kubernetes/server.key --v=2

    Nov 10 22:43:54 localhost.localdomain systemd[1]: Starting Kubernetes API server...
    Nov 10 22:43:54 localhost.localdomain kube-apiserver[5842]: I1110 22:43:54.411559    5842 genericapiserver.go:606] Will report 10.64.33.81 as public IP address.
    Nov 10 22:43:54 localhost.localdomain kube-apiserver[5842]: I1110 22:43:54.412884    5842 genericapiserver.go:288] Node port range unspecified. Defaulting to 30000-32767.
    Nov 10 22:43:54 localhost.localdomain kube-apiserver[5842]: [restful] 2016/11/10 22:43:54 log.go:30: [restful/swagger] listing is available at https://10.64.33.81:6443/swaggerapi/
    Nov 10 22:43:54 localhost.localdomain kube-apiserver[5842]: [restful] 2016/11/10 22:43:54 log.go:30: [restful/swagger] https://10.64.33.81:6443/swaggerui/ is mapped to folder /swagger-ui/
    Nov 10 22:43:54 localhost.localdomain kube-apiserver[5842]: I1110 22:43:54.505181    5842 genericapiserver.go:690] Serving securely on 0.0.0.0:6443
    Nov 10 22:43:54 localhost.localdomain kube-apiserver[5842]: I1110 22:43:54.505191    5842 genericapiserver.go:734] Serving insecurely on 127.0.0.1:8080
    Nov 10 22:43:54 localhost.localdomain systemd[1]: Started Kubernetes API server.

Deep dive int kube-apiserver

    [vagrant@localhost ~]$ etcdctl ls
    /registry
    [vagrant@localhost ~]$ etcdctl ls /registry
    /registry/namespaces
    /registry/services
    /registry/ranges
    [vagrant@localhost ~]$ etcdctl ls /registry/ranges
    /registry/ranges/servicenodeports
    /registry/ranges/serviceips
    [vagrant@localhost ~]$ etcdctl get /registry/ranges/serviceips
    {"kind":"RangeAllocation","apiVersion":"v1","metadata":{"creationTimestamp":null},"range":"10.123.240.0/20","data":"AQ=="}

    [vagrant@localhost ~]$ curl http://127.0.0.1:8080/
    {
      "paths": [
        "/api",
        "/api/v1",
        "/apis",
        "/apis/apps",
        "/apis/apps/v1alpha1",
        "/apis/autoscaling",
        "/apis/autoscaling/v1",
        "/apis/batch",
        "/apis/batch/v1",
        "/apis/batch/v2alpha1",
        "/apis/extensions",
        "/apis/extensions/v1beta1",
        "/apis/policy",
        "/apis/policy/v1alpha1",
        "/apis/rbac.authorization.k8s.io",
        "/apis/rbac.authorization.k8s.io/v1alpha1",
        "/healthz",
        "/healthz/ping",
        "/logs/",
        "/metrics",
        "/swaggerapi/",
        "/ui/",
        "/version"
      ]

      [vagrant@localhost ~]$ sudo curl --cacert /srv/kubernetes/ca.crt --cert /srv/kuernetes/kubecfg.crt --key /srv/kubernetes/kubecfg.key https://10.64.33.81:6443/api
      {
        "kind": "APIVersions",
        "versions": [
          "v1"
        ],
        "serverAddressByClientCIDRs": [
          {
            "clientCIDR": "0.0.0.0/0",
            "serverAddress": "10.64.33.81:6443"
          }
        ]
      }

Configure *kubectl*

    [vagrant@localhost ~]$ kubectl config set-cluster kube --server=https://10.64.33.81:6443
    cluster "kube" set.

    [vagrant@localhost ~]$ encoded=$(sudo base64 -w0 /srv/kubernetes/ca.crt); kubectl config set clusters.kube.certificate-authority-data "$encoded"
    property "clusters.kube.certificate-authority-data" set.

    [vagrant@localhost ~]$ kubectl config set-credentials admin
    user "admin" set.

    [vagrant@localhost ~]$ encoded=$(sudo base64 -w0 /srv/kubernetes/kubecfg.crt); kubectl config set users.admin.client-certificate-data "$encoded"
    property "users.admin.client-certificate-data" set.

    [vagrant@localhost ~]$ encoded=$(sudo base64 -w0 /srv/kubernetes/kubecfg.key); kubectl config set users.admin.client-key-data "$encoded"
    property "users.admin.client-key-data" set.

    [vagrant@localhost ~]$ kubectl config set-context kube-admin --cluster=kube --user=admin
    context "kube-admin" set.

    [vagrant@localhost ~]$ kubectl config use-context kube-admin
    switched to context "kube-admin".

    [vagrant@localhost ~]$ cat .kube/config

    [vagrant@localhost ~]$ kubectl version
    Client Version: version.Info{Major:"1", Minor:"3+", GitVersion:"v1.3.10-dirty", GitCommit:"c3e367ec9eae7338ac4e2a57f293634891319b7c", GitTreeState:"dirty", BuildDate:"2016-11-09T15:11:23Z", GoVersion:"go1.6.2", Compiler:"gc", Platform:"linux/amd64"}
    Server Version: version.Info{Major:"1", Minor:"3+", GitVersion:"v1.3.10-dirty", GitCommit:"c3e367ec9eae7338ac4e2a57f293634891319b7c", GitTreeState:"dirty", BuildDate:"2016-11-09T15:11:23Z", GoVersion:"go1.6.2", Compiler:"gc", Platform:"linux/amd64"}

    [vagrant@localhost ~]$ kubectl api-versions
    apps/v1alpha1
    autoscaling/v1
    batch/v1
    batch/v2alpha1
    extensions/v1beta1
    policy/v1alpha1
    rbac.authorization.k8s.io/v1alpha1
    v1

* The kube-controller-manager

Service and env file

    [vagrant@localhost ~]$ vi kubernetes/1.3.10/centos/systemd/system/kube-controller-manager.service
    [Unit]
    Description=Kubernetes controller manager
    Documentation=https://github.com/kubernetes/kubernetes
    # After=
    # Requires=
    # Wants=
    # Conflicts=

    [Service]
    Type=notify
    User=root

    WorkingDirectory=/opt/kubernetes

    Environment=KUBERNETES_RELEASE_VERSION=1.3.10
    EnvironmentFile=/etc/sysconfig/kube-controller-manager

    ExecStart=/opt/kubernetes/server/bin/kube-controller-manager $KUBE_CTLMGR_OPTS

    Restart=on-failure

    [Install]
    WantedBy=multi-user.target

    [vagrant@localhost ~]$ vi kubernetes/1.3.10/centos/systemd/conf/kube-controller-manager
    # KUBE_CTLMGR_VERSION=1.3.10

    HOSTNAME_OVERRIDE=10.64.33.81

    # --cloud-config="": The path to the cloud provider configuration file

    # --cloud-provider="": The provider for cloud services

    # --service-cluster-ip-range=<nil>: A CIDR notation IP range
    # Same as GKE, cluster CIDR: 10.120.0.0/14, service CIDR: 10.123.240.0/20
    SERVICE_CIDR=10.123.240.0/20
    # SERVICE_MASTER=10.123.240.1
    # SERVICE_DNS=10.123.240.10

    # --service-node-port-range=: default '30000-32767'

    KUBE_CTLMGR_OPTS="--address=0.0.0.0 \
      --cluster-cidr=10.120.0.0/14 \
      --cluster-name=kubernetes \
      --enable-garbage-collector=false \
      --kubeconfig=/srv/kubernetes/kubeconfig \
      --master=https://10.64.33.81:6443 \
      --port=10252 \
      --root-ca-file=/srv/kubernetes/ca.crt \
      --service-account-private-key-file=/srv/kubernetes/server.key \
      --service-cluster-ip-range=10.123.240.0/20 \
      --v=2"

Manually install

    [vagrant@localhost ~]$ sudo cp .kube/config /srv/kubernetes/kubeconfig

    [vagrant@localhost ~]$ sudo cp kubernetes/1.3.10/centos/systemd/conf/kube-controller-manager /etc/sysconfig/

    [vagrant@localhost ~]$ sudo cp kubernetes/1.3.10/centos/systemd/system/kube-controller-manager.service /etc/systemd/system

    [vagrant@localhost ~]$ sudo systemctl enable kube-controller-manager.service    Created symlink from /etc/systemd/system/multi-user.target.wants/kube-controller-manager.service to /etc/systemd/system/kube-controller-manager.service.

    [vagrant@localhost ~]$ sudo systemctl start kube-controller-manager.service
    Job for kube-controller-manager.service failed because the control process exited with error code. See "systemctl status kube-controller-manager.service" and "journalctl -xe" for details.

    [vagrant@localhost ~]$ sudo systemctl daemon-reload

    [vagrant@localhost ~]$ sudo systemctl restart kube-controller-manager

* The kube-scheduler

Env and service file

[vagrant@localhost ~]$ cat kubernetes/centos/kube-scheduler.service
[Unit]
Description=Kubernetes scheduler
Documentation=https://github.com/kubernetes/kubernetes
# After=
# Requires=
# Wants=
# Conflicts=

[Service]
Type=notify
User=root
WorkingDirectory=/opt/kubernetes

Environment=KUBE_SCHDULER_VERSION=1.3.10
Environment=HOSTNAME_OVERRIDE=10.64.33.81

ExecStart=/opt/kubernetes/$KUBE_SCHDULER_VERSION/kube-scheduler \
  --address=0.0.0.0 \
  --algorithm-provider=DefaultProvider \
  --kubeconfig="" \
  --master=https://10.64.33.81 \
  --policy-config-file="" \
  --port=10251 \
  --scheduler-name=default-scheduler \
  --v=2

Restart=On-Failure

[Install]
WantBy=multi-user.target


[vagrant@localhost ~]$ cat kubernetes/centos/kube-proxy.service
[Unit]
Description=Kubernetes proxy networking
Documentation=https://github.com/kubernetes/kubernetes
# After=
# Requires=
# Wants=
# Conflicts=

[Service]
Type=notify
User=root
WorkingDirectory=/opt/kubernetes

Environment=KUBE_PROXY_VERSION=1.3.10
Environment=HOSTNAME_OVERRIDE=10.64.33.81

ExecStart=/opt/kubernetes/$KUBE_PROXY_VERSION/kube-proxy \
  --bind-address=0.0.0.0 \
  --cluster-cidr="" \
  --hostname-override=$HOSTNAME_OVERRIDE \
  --kubeconfig="" \
  --master=https://10.64.33.81 \
  --v=2

Restart=On-Failure

[Install]
WantBy=multi-user.target


[vagrant@localhost ~]$ cat kubernetes/centos/kubelet.service
[Unit]
Description=Kubernetes daemon - kubelet
Documentation=https://github.com/kubernetes/kubernetes
After=docker.service flanneld.service
Requires=network.target
# Wants=
# Conflicts=openshift-node.service

[Service]
Type=notify
User=root
WorkingDirectory=/var/lib/kubelet

Environment=KUBELET_VERSION=1.3.10
Environment=HOSTNAME_OVERRIDE=10.64.33.81

ExecStartPre=/usr/bin/mkdir -p /opt/kubernetes/manifests
ExecStartPre=/usr/bin/mkdir -p /var/log/containers

ExecStart=/opt/kubernetes/${KUBELET_VERSION}/kubelet \
  --address=0.0.0.0 --allow-privileged=true \
  --api-servers=https://${HOSTNAME_OVERRIDE} \
  --cert-dir=/srv/kubernetes \
  --cloud-provider="" \
  --cluster_dns=172.30.0.10 \
  --cluster_domain=cluster.local \
  --config=/opt/kubernetes/manifests \
  --network-plugin=cni \
  --hostname_override=${HOSTNAME_OVERRIDE} \
  --kubeconfig=/opt/kubernetes/kubeconfig \
  --master_service_namespace=default \
  --node_ip=${HOSTNAME_OVERRIDE} \
  --pod_infra_container_image=gcr.io/google_containers/pause-amd64:3.0 \
  --port=10250 \
  --v=2

Restart=always
RestartSec=10
KillMode=process

[Install]
WantedBy=multi-user.target


* Run as PODs

Reference

    https://github.com/coreos/coreos-kubernetes/blob/v0.4.0/multi-node/generic/controller-install.sh
