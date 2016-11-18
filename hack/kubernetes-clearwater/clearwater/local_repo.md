
### A `cw-ngv` local repo

Install and run tool

    ubuntu@ubuntu-14-04-3-server-amd64: ~$ sudo apt-get install apt-mirror

    ubuntu@ubuntu-14-04-3-server-amd64: ~$ sudo vi /etc/apt/mirror.list

    deb http://repo.cw-ngv.com/stable binary

    clean http://repo.cw-ngv.com/stable

    ubuntu@ubuntu-14-04-3-server-amd64: ~$ sudo apt-mirror

    ubuntu@ubuntu-14-04-3-server-amd64: ~$ ls /var/spool/apt-mirror/mirror/repo.cw-ngv.com/stable/binary/

    ubuntu@ubuntu-14-04-3-server-amd64: ~$ rsync -avz -e ssh --delete /var/spool/apt-mirror/mirror/repo.cw-ngv.com tangf@192.168.0.250:/cygdrive/f/16-mirror/apt-mirror/mirror

Cache repo gpg

    tangf@DESKTOP-H68OQDV /cygdrive/g/work/src/github.com/Metaswitch/clearwater-docker/base
    $ curl -L http://repo.cw-ngv.com/repo_key -o /cygdrive/f/16-mirror/apt-mirror/gpg-key/repo.cw-ngv.com/repo_key
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
    100  3149  100  3149    0     0   3002      0  0:00:01  0:00:01 --:--:--  4928

Run `gofileserver`

    tangf@DESKTOP-H68OQDV /cygdrive/f/16-mirror/apt-mirror/trusty
    $ gofileserver.exe
    Listening at  :48080

    tangf@DESKTOP-H68OQDV /cygdrive/g/atlas.hashicorp.com/centos/boxes/7
    $ curl http://10.64.33.1:48080/
    <pre>
    <a href="gpg-key/">gpg-key/</a>
    <a href="mirror/">mirror/</a>
    </pre>

    tangf@DESKTOP-H68OQDV /cygdrive/g/atlas.hashicorp.com/centos/boxes/7
    $ curl -sL http://10.64.33.1:48080/gpg-key/http%253A%252F%252Frepo.cw-ngv.com/repo_key -o-
