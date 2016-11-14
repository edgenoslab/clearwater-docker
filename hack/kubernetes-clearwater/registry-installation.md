Instruction
------------

Image pull or load

    [vagrant@localhost ~]$ docker pull docker.io/registry:2.4.1
    Trying to pull repository docker.io/library/registry ...
    2.4.1: Pulling from docker.io/library/registry
    5c90d4a2d1a8: Pull complete
    fb8b2153aae6: Pull complete
    f719459a7672: Pull complete
    fa42982c9892: Pull complete
    Digest: sha256:504b44c0ca43f9243ffa6feaf3934dd57895aece36b87bc25713588cdad3dd10
    Status: Downloaded newer image for docker.io/registry:2.4.1

    [vagrant@localhost ~]$ docker load --input=docker.io%2Fregistry%3A2.4.1.tar

### Install as a `kubernetes` POD

Create kubernetes namespace

    [vagrant@localhost ~]$ vi kubernetes/registry/2.4.1/stackdocker-namespace.yaml
    apiVersion: v1
    kind: Namespace
    metadata:
    name: stackdocker

* Registry account

Create `htpasswd`

    [vagrant@localhost ~]$ docker run --entrypoint=htpasswd --rm registry:2.4.1 -Bbn admin admin123 > htpasswd

    [vagrant@localhost ~]$ mv htpasswd kubernetes/registry/2.4.1/htpasswd

Kubernetes `Secret`

    [vagrant@localhost ~]$ echo "admin:$2y$05$PjSkj20tpMSWabyzrpTMlug/sUgwXA7VZNmpl0w/xloLoO6drBINC" | base64 -w 0
    YWRtaW46JDJ5JDA1JEpCNUVUdUxrODFoMmhIZTlFSkZkZk9peDh2R005M2o0c1k1QmZrRkxqR0FjMmZuZjByWDh1Cgo=    

    [vagrant@localhost ~]$ vi kubernetes/registry/2.4.1/htpasswd-secret.yaml
    apiVersion: v1
    kind: Secret
    metadata:
      name: registry-htpasswd
      namespace: stackdocker
    data:
      htpasswd: *<the htpasswd base64 encoded data>*
    type: Opaque

* Self-signed Cert

Reference

    https://github.com/stackdocker/log-courier/blob/master/lc-tlscert/lc-tlscert.go

Build in `Golang`

    [vagrant@localhost ~]$ go get github.com/stackdocker/log-courier/lc-tlscert

Generate

    [vagrant@localhost ~]$ lc-tlscert
    Specify the Common Name for the certificate. The common name
    can be anything, but is usually set to the server's primary
    DNS name. Even if you plan to connect via IP address you
    should specify the DNS name here.

    Common name: 10.64.33.81:5000

    The next step is to add any additional DNS names and IP
    addresses that clients may use to connect to the server. If
    you plan to connect to the server via IP address and not DNS
    then you must specify those IP addresses here.
    When you are finished, just press enter.

    DNS or IP address 1: 10.64.33.81
    DNS or IP address 2: 10.123.240.35
    DNS or IP address 3: registry.default.svc.cluster.local
    DNS or IP address 4: registry.stackdocker.svc.cluster.local
    DNS or IP address 5:


    How long should the certificate be valid for? A year (365
    days) is usual but requires the certificate to be regenerated
    within a year or the certificate will cease working.

    Number of days: 1000
    Common name: 10.64.33.81:5000
    DNS SANs:
        registry.default.svc.cluster.local
        registry.stackdocker.svc.cluster.local
    IP SANs:
        10.64.33.81
        10.123.240.35        

    The certificate can now be generated
    Press any key to begin generating the self-signed certificate.

    Successfully generated certificate
        Certificate: selfsigned.crt
        Private Key: selfsigned.key

    Copy and paste the following into your Log Courier
    configuration, adjusting paths as necessary:
        "transport": "tls",
        "ssl ca":    "path/to/selfsigned.crt",

    Copy and paste the following into your LogStash configuration,
    adjusting paths as necessary:
        ssl_certificate => "path/to/selfsigned.crt",
        ssl_key         => "path/to/selfsigned.key",

Add in `docker-engine` option, e.g. *worker nodes* and any of this *registry clients*

    [vagrant@localhost ~]$ sudo mkdir -p /etc/docker/certs.d/10.64.33.81:5000

    [vagrant@localhost ~]$ sudo cp selfsigned.crt /etc/docker/certs.d/10.64.33.81\:5000/ca.crt

    [vagrant@localhost ~]$ sudo cp selfsigned.key /etc/docker/certs.d/10.64.33.81\:5000/tls.key

    [vagrant@localhost 2.4.1]$ sudo vi /etc/sysconfig/docker
    # Modify these options if you want to change the way the docker daemon runs
    OPTIONS='--selinux-enabled --log-driver=journald --insecure-registry=192.168.0.0/16 --insecure-registry=172.16.0.0/12 --insecure-registry=10.0.0.0/8'

    [vagrant@localhost 2.4.1]$ sudo systemctl restart docker.service

Save for clients used laterly

    [vagrant@localhost ~]$ mv selfsigned.crt kubernetes/registry/2.4.1/tls.crt

    [vagrant@localhost ~]$ mv selfsigned.key kubernetes/registry/2.4.1/tls.key

kubernetes `secret`

    [vagrant@localhost ~]$ base64 -w 0 kubernetes/registry/2.4.1/tls.crt

    [vagrant@localhost ~]$ base64 -w 0 kubernetes/registry/2.4.1/tls.key

    [vagrant@localhost ~]$ vi kubernetes/registry/2.4.1/tls-secret.yaml
    apiVersion: v1
    kind: Secret
    metadata:
      name: registry-tls
      namespace: stackdocker
    type: kubernetes.io/tls
    data:
      tls.crt: *<the tls.crt base64 encoded data>*
      tls.key: *<the tls.key base64 encoded data>*

* Configuration

Reference

    https://github.com/docker/distribution/blob/master/docs/configuration.md#registry-configuration-reference

    [vagrant@localhost ~]$ vi kubernetes/registry/2.4.1/config.yml
    version: 0.1
    log:
      fields:
        service: registry
    storage:
      cache:
        blobdescriptor: inmemory
      filesystem:
        rootdirectory: /var/lib/registry
    http:
      addr: :5000
      headers:
        X-Content-Type-Options: [nosniff]
    health:
      storagedriver:
        enabled: true
        interval: 30s
        threshold: 3
    auth:
      htpasswd:
        realm: basic-realm
        path: /auth/htpasswd

    [vagrant@localhost ~]$ vi kubernetes/registry/2.4.1/config-configmap.yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: registry-config
      namespace: stackdocker
    data:
      config.yml: |
        version: 0.1
        log:
          fields:
            service: registry
        storage:
          cache:
            blobdescriptor: inmemory
          filesystem:
            rootdirectory: /var/lib/registry
        http:
          addr: :5000
          headers:
            X-Content-Type-Options: [nosniff]
        health:
          storagedriver:
            enabled: true
            interval: 30s
            threshold: 3
        auth:
          htpasswd:
            realm: basic-realm
            path: /auth/htpasswd

* Kubernetes manifests

deployment

    [vagrant@localhost ~]$ vi kubernetes/registry/2.4.1/registry-deployment.yaml
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: registry
      namespace: stackdocker
    spec:
      replicas: 1
      strategy:
        type: RollingUpdate
      selector:
        matchLabels:
          stackdocker-app: docker-distribution
      template:
        metadata:
          labels:
            stackdocker-app: docker-distribution
        spec:
          containers:
          - env:
            - name: DOCKER_REGISTRY_CONFIG
              value: /etc/docker/registry/config.yml
            - name: REGISTRY_HTTP_TLS_CERTIFICATE
              value: /certs/tls.crt
            - name: REGISTRY_HTTP_TLS_KEY
              value: /certs/tls.key
            - name: REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY
              value: /var/lib/registry
            image: docker.io/registry:2.4.1
            name: registry
            ports:
            - containerPort: 5000
              hostIP: 10.64.33.81
              hostPort: 5000
            securityContext:
              privileged: true
            volumeMounts:
            - name: basic-realm
              mountPath: /auth
              readOnly: true
            - name: selfsigned-tls
              mountPath: /certs
              readOnly: true
            - name: config
              mountPath: /etc/docker/registry
              readOnly: true
            - name: repo
              mountPath: /var/lib/registry
          volumes:
          - name: basic-realm
            secret:
              secretName: registry-htpasswd
              items:
              - key: htpasswd
                path: htpasswd
          - name: selfsigned-tls
            secret:
              secretName: registry-tls
              items:
              - key: tls.crt
                path: tls.crt
              - key: tls.key
                path: tls.key
          - name: config
            configMap:
              name: registry-config
              items:
              - key: config.yml
                path: config.yml
          - name: repo
            hostPath: /var/lib/registry    

Service

    [vagrant@localhost ~]$ vi kubernetes/registry/2.4.1/registry-service.yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: registry
      namespace: stackdocker
    spec:
      clusterIP: 10.123.240.35
      ports:
      - port: 5000
      selector:
        stackdocker-app: docker-distribution

* Start

    [vagrant@localhost ~]$ kubectl create -f kubernetes/registry/2.4.1/config-configmap.yaml
    configmap "registry-config" created

    [vagrant@localhost ~]$ kubectl create -f kubernetes/registry/2.4.1/htpasswd-secret.yaml
    secret "registry-htpasswd" created

    [vagrant@localhost ~]$ kubectl create -f kubernetes/registry/2.4.1/tls-secret.yaml
    secret "registry-tls" created

    [vagrant@localhost ~]$ kubectl create -f kubernetes/registry/2.4.1/registry-deployment.yaml
    deployment "registry" created

    [vagrant@localhost ~]$ kubectl create -f kubernetes/registry/2.4.1/registry-service.yaml
    service "registry" created

* Validate    

    [vagrant@localhost ~]$ kubectl --namespace=stackdocker get pods,ep,svc -o wide
    NAME                        READY              STATUS    RESTARTS   AGE       IP            NODE
    registry-2499285598-mp80z   1/1                Running   0          1m        10.121.24.5   10.64.33.81
    NAME                        ENDPOINTS          AGE
    registry                    10.121.24.5:5000   40s
    NAME                        CLUSTER-IP         EXTERNAL-IP   PORT(S)    AGE       SELECTOR
    registry                    10.123.240.35      <none>        5000/TCP   40s       stackdocker-app=docker-distribution

    [vagrant@localhost ~]$ kubectl --namespace=stackdocker logs registry-2499285598-mp80z
    time="2016-11-14T21:18:08Z" level=warning msg="Ignoring unrecognized environment variable REGISTRY_PORT"
    time="2016-11-14T21:18:08Z" level=warning msg="Ignoring unrecognized environment variable REGISTRY_PORT_5000_TCP"
    time="2016-11-14T21:18:08Z" level=warning msg="Ignoring unrecognized environment variable REGISTRY_PORT_5000_TCP_ADDR"
    time="2016-11-14T21:18:08Z" level=warning msg="Ignoring unrecognized environment variable REGISTRY_PORT_5000_TCP_PORT"
    time="2016-11-14T21:18:08Z" level=warning msg="Ignoring unrecognized environment variable REGISTRY_PORT_5000_TCP_PROTO"
    time="2016-11-14T21:18:08Z" level=warning msg="Ignoring unrecognized environment variable REGISTRY_SERVICE_HOST"
    time="2016-11-14T21:18:08Z" level=warning msg="Ignoring unrecognized environment variable REGISTRY_SERVICE_PORT"
    time="2016-11-14T21:18:08Z" level=warning msg="No HTTP secret provided - generated random secret. This may cause problems with uploads if multiple registries are behind a load-balancer. To provide a shared secret, fill in http.secret in the configuration file or set the REGISTRY_HTTP_SECRET environment variable." go.version=go1.6.2 instance.id=bd30687b-c884-4f01-8164-1b40abbc6bee version=v2.4.1
    time="2016-11-14T21:18:08Z" level=info msg="redis not configured" go.version=go1.6.2 instance.id=bd30687b-c884-4f01-8164-1b40abbc6bee version=v2.4.1
    time="2016-11-14T21:18:08Z" level=info msg="Starting upload purge in 52m0s" go.version=go1.6.2 instance.id=bd30687b-c884-4f01-8164-1b40abbc6bee version=v2.4.1
    time="2016-11-14T21:18:08Z" level=info msg="using inmemory blob descriptor cache" go.version=go1.6.2 instance.id=bd30687b-c884-4f01-8164-1b40abbc6bee version=v2.4.1
    time="2016-11-14T21:18:08Z" level=info msg="listening on [::]:5000, tls" go.version=go1.6.2 instance.id=bd30687b-c884-4f01-8164-1b40abbc6bee version=v2.4.1

    [vagrant@localhost ~]$ sudo netstat -tpnl | grep docker-proxy
    tcp        0      0 10.64.33.81:5000        0.0.0.0:*               LISTEN      27818/docker-proxy

    [vagrant@localhost ~]$ docker login -u admin -p admin123 10.64.33.81:5000
    Email:
    WARNING: login credentials saved in /home/vagrant/.docker/config.json
    Login Succeeded

    [vagrant@localhost ~]$ docker tag tangfeixiong/netcat-hello-http 10.64.33.81:5000/netcat-hello-http

    [vagrant@localhost ~]$ docker push 10.64.33.81:5000/netcat-hello-http
    The push refers to a repository [10.64.33.81:5000/netcat-hello-http]
    5f70bf18a086: Pushed
    14996164fa4d: Pushed
    000ac623049f: Pushed
    3f50a8137adf: Pushed
    latest: digest: sha256:e21c11edf699f9c582b46388f269a44ee5f0662b099cca7cfd30d5c6970cf563 size: 1748

    [vagrant@localhost ~]$ ls /var/lib/registry/docker/registry/v2/repositories/
    netcat-hello-http

### Install as `systemd` service

In Official mirror repo

    [vagrant@localhost ~]$ sudo yum list docker-distribution
    Loaded plugins: fastestmirror
    Loading mirror speeds from cached hostfile
     * base: mirrors.zju.edu.cn
     * extras: mirrors.zju.edu.cn
     * updates: mirrors.zju.edu.cn
    Available Packages
    docker-distribution.x86_64                                                                                                                  2.4.1-2.el7                                                                                                                  extras

Install from Official mirror

    [vagrant@localhost ~]$ sudo yum install docker-distribution
    Loaded plugins: fastestmirror
    base
    centos-openshift-origin
    extras
    updates
    Loading mirror speeds from cached hostfile
     * base: mirrors.zju.edu.cn
     * extras: mirrors.zju.edu.cn
     * updates: mirrors.zju.edu.cn
    Resolving Dependencies
    --> Running transaction check
    ---> Package docker-distribution.x86_64 0:2.4.1-2.el7 will be installed
    --> Finished Dependency Resolution

    Dependencies Resolved

    ================================================================================
     Package                                                                   Arch
    ================================================================================
    Installing:
     docker-distribution                                                       x86_6

    Transaction Summary
    ================================================================================
    Install  1 Package

Service

    [vagrant@localhost ~]$ sudo vi /usr/lib/systemd/system/docker-distribution.service
    [Unit]
    Description=v2 Registry server for Docker

    [Service]
    Type=simple
    ExecStart=/usr/bin/registry serve /etc/docker-distribution/registry/config.yml
    Restart=on-failure

    [Install]
    WantedBy=multi-user.starget

Configuration

    [vagrant@localhost ~]$ sudo vi /etc/docker-distribution/registry/config.yml
    version: 0.1
    log:
      fields:
        service: registry
    storage:
        cache:
            layerinfo: inmemory
        filesystem:
            rootdirectory: /var/lib/registry
    http:
        addr: :5000

    [vagrant@localhost ~]$ sudo ls -d /var/lib/registry/
    /var/lib/registry/
