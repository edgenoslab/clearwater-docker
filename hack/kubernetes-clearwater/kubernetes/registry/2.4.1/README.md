
## Content

### htpasswd

Refer to https://github.com/docker/distribution/blob/v2.4.1/docs/deploying.md#native-basic-auth

Example here is using *admin* as user name, and *password* as password

    [vagrant@master81 2.4.1]$ USERNAME=admin && PASSWORD=password && docker run --rm --entrypoint htpasswd docker.io/registry:2.4.1 -Bbn $USERNAME $PASSWORD > htpasswd

Or

	[vagrant@master81 2.4.1]$ sudo yum install httpd-tools

	[vagrant@master81 2.4.1]$ htpasswd --help
	Usage:
			htpasswd [-cimBdpsDv] [-C cost] passwordfile username
			htpasswd -b[cmBdpsDv] [-C cost] passwordfile username password

			htpasswd -n[imBdps] [-C cost] username
			htpasswd -nb[mBdps] [-C cost] username password
	 -c  Create a new file.
	 -n  Don't update file; display results on stdout.
	 -b  Use the password from the command line rather than prompting for it.
	 -i  Read password from stdin without verification (for script usage).
	 -m  Force MD5 encryption of the password (default).
	 -B  Force bcrypt encryption of the password (very secure).
	 -C  Set the computing time used for the bcrypt algorithm
		 (higher is more secure but slower, default: 5, valid: 4 to 31).
	 -d  Force CRYPT encryption of the password (8 chars max, insecure).
	 -s  Force SHA encryption of the password (insecure).
	 -p  Do not encrypt the password (plaintext, insecure).
	 -D  Delete the specified user.
	 -v  Verify password for the specified user.
	On other systems than Windows and NetWare the '-p' flag will probably not work.
	The SHA algorithm does not use a salt and is less secure than the MD5 algorithm.
	
Base64

    [vagrant@master81 2.4.1]$ base64 -w0 htpasswd
    YWRtaW46JDJ5JDA1JFZoblU4OFk0Lmo0WUh2QkV1c1JOMC45MkdzVnFjL244SWFCbXJCdVNNVXl5Zk96NWlaV2xpCgo=

### tls



