# tfe-proxy-selfsigned-vagrant
What : Install TFE on Demo version with Self Sign Certificate - proxy with self sign certifcate - vagrant  
How : TFE > Man-in-the-middle proxy via mitmproxy > Internet.  
Why : Learn TFE

## Pre-requirements

* [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) 
* [Vagrant](https://www.vagrantup.com/docs/installation)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)


## How to use this repo

- Clone
- Run
- Cleanup

---

### Clone the repo

```
git clone https://github.com/viv-garot/tfe-proxy-selfsigned-vagrant
```

### Change directory

```
cd tfe-proxy-selfsigned-vagrant
```

### Run

* Copy your license file to config/license.rli (for TF Support Engineer, check 1Password Support Engineering Vault, hashicorp-internall---support.rli)

```
cp /path/to/your/license config/license.rli
```

_sample_ :

```
cp ~/Downloads/hashicorp-internal---support.rli config/license.rli
```

* Bring up the VMs:

```
vagrant up
```

_sample_:

```
vagrant up
Bringing machine 'mitmproxy' up with 'virtualbox' provider...
Bringing machine 'tfe' up with 'virtualbox' provider...
==> mitmproxy: Importing base box 'vivien/bionic64'...
==> mitmproxy: Matching MAC address for NAT networking...
==> mitmproxy: Checking if box 'vivien/bionic64' version '21.07.06' is up to date...
==> mitmproxy: Setting the name of the VM: mitmproxy-vagrant_mitmproxy_1631260867828_21521
==> mitmproxy: Clearing any previously set network interfaces...
==> mitmproxy: Preparing network interfaces based on configuration...
    mitmproxy: Adapter 1: nat
    mitmproxy: Adapter 2: hostonly
==> mitmproxy: Forwarding ports...
    mitmproxy: 22 (guest) => 2222 (host) (adapter 1)
==> mitmproxy: Running 'pre-boot' VM customizations...
==> mitmproxy: Booting VM...
==> mitmproxy: Waiting for machine to boot. This may take a few minutes...
    mitmproxy: SSH address: 127.0.0.1:2222
    mitmproxy: SSH username: vagrant
    mitmproxy: SSH auth method: private key
        
 [ ... ]
 
    mitmproxy: Otherwise pipx is ready to go! ✨ 🌟 ✨
    mitmproxy: ⚠️  Note: '/home/vagrant/.local/bin' is not on your PATH environment variable.
    mitmproxy:     These apps will not be globally accessible until your PATH is updated. Run
    mitmproxy:     `pipx ensurepath` to automatically add it, or manually modify your PATH in
    mitmproxy:     your shell's config file (i.e. ~/.bashrc).
    mitmproxy: creating virtual environment...
    mitmproxy: creating shared libraries...
    mitmproxy: upgrading shared libraries...
    mitmproxy: installing mitmproxy...
    mitmproxy:   installed package mitmproxy 5.3.0, Python 3.6.9
    mitmproxy:   These apps are now globally available
    mitmproxy:     - mitmdump
    mitmproxy:     - mitmproxy
    mitmproxy:     - mitmweb
    mitmproxy:     - pathoc
    mitmproxy:     - pathod
    mitmproxy: done! ✨ 🌟 ✨
    mitmproxy: Created symlink /etc/systemd/system/multi-user.target.wants/mitmproxy.service → /etc/systemd/system/mitmproxy.service.
==> tfe: Importing base box 'vivien/bionic64'...
==> tfe: Matching MAC address for NAT networking...
==> tfe: Checking if box 'vivien/bionic64' version '21.07.06' is up to date...
==> tfe: Setting the name of the VM: mitmproxy-vagrant_tfe_1631260940272_47524
==> tfe: Fixed port collision for 22 => 2222. Now on port 2200.
==> tfe: Clearing any previously set network interfaces...
==> tfe: Preparing network interfaces based on configuration...
    tfe: Adapter 1: nat
    tfe: Adapter 2: hostonly
==> tfe: Forwarding ports...
    tfe: 22 (guest) => 2200 (host) (adapter 1)
==> tfe: Running 'pre-boot' VM customizations...
==> tfe: Booting VM...
==> tfe: Waiting for machine to boot. This may take a few minutes...
    tfe: SSH address: 127.0.0.1:2200
    tfe: SSH username: vagrant
    tfe: SSH auth method: private key
            
 [ ... ]
    
    tfe: dfe99bc54bd2: Verifying Checksum
    tfe: dfe99bc54bd2: Download complete
    tfe: 4aefde41dc06:
    tfe: Pull complete
    tfe: dfe99bc54bd2: Pull complete
    tfe: 932531148e85: Verifying Checksum
    tfe: 932531148e85: Download complete
    tfe: 932531148e85: Pull complete
    tfe: Digest: sha256:33b33b28c915cff56ddcb426847ee192eb0f7873fc44b2cd9ffa0b2a684f8e31
    tfe: Status: Downloaded newer image for replicated/replicated-operator:stable-2.53.0
    tfe: docker.io/replicated/replicated-operator:stable-2.53.0
    tfe: Tagging replicated-operator image
    tfe: Stopping replicated-operator service
    tfe: Installing replicated-operator service
    tfe: Starting replicated-operator service
    tfe: Created symlink /etc/systemd/system/docker.service.wants/replicated-operator.service → /etc/systemd/system/replicated-operator.service.
    tfe:
    tfe: Operator installation successful
    tfe: To continue the installation, visit the following URL in your browser:
    tfe:
    tfe:   http://192.168.20.11:8800   
     
```

* TFE components need some time for first initialization.  You may poll the _/_health_check_ endpoint until a _200_ is returned by the application, indicating that it is fully started:

```
while ! curl -ksfS --connect-timeout 5 https://192.168.20.11/_health_check; do sleep 5 ; done
```

_sample_:

```
while ! curl -ksfS --connect-timeout 5 https://192.168.20.11/_health_check; do sleep 5 ; done
curl: (7) Failed to connect to 192.168.20.11 port 443: Connection refused
curl: (7) Failed to connect to 192.168.20.11 port 443: Connection refused
curl: (7) Failed to connect to 192.168.20.11 port 443: Connection refused
curl: (7) Failed to connect to 192.168.20.11 port 443: Connection refused
curl: (7) Failed to connect to 192.168.20.11 port 443: Connection refused
curl: (7) Failed to connect to 192.168.20.11 port 443: Connection refused
curl: (7) Failed to connect to 192.168.20.11 port 443: Connection refused
curl: (7) Failed to connect to 192.168.20.11 port 443: Connection refused
curl: (7) Failed to connect to 192.168.20.11 port 443: Connection refused
curl: (7) Failed to connect to 192.168.20.11 port 443: Connection refused
curl: (7) Failed to connect to 192.168.20.11 port 443: Connection refused
curl: (7) Failed to connect to 192.168.20.11 port 443: Connection refused
curl: (22) The requested URL returned error: 502 Bad Gateway
curl: (22) The requested URL returned error: 502 Bad Gateway
curl: (22) The requested URL returned error: 502 Bad Gateway
curl: (22) The requested URL returned error: 502 Bad Gateway
curl: (22) The requested URL returned error: 502 Bad Gateway
curl: (22) The requested URL returned error: 502 Bad Gateway
curl: (22) The requested URL returned error: 502 Bad Gateway
curl: (22) The requested URL returned error: 502 Bad Gateway
curl: (22) The requested URL returned error: 502 Bad Gateway
curl: (22) The requested URL returned error: 502 Bad Gateway
curl: (22) The requested URL returned error: 502 Bad Gateway
curl: (22) The requested URL returned error: 502 Bad Gateway
curl: (22) The requested URL returned error: 502 Bad Gateway
curl: (22) The requested URL returned error: 502 Bad Gateway
curl: (22) The requested URL returned error: 502 Bad Gateway
curl: (22) The requested URL returned error: 502 Bad Gateway
curl: (22) The requested URL returned error: 502 Bad Gateway
curl: (22) The requested URL returned error: 502 Bad Gateway
{"postgres":"UP","redis":"UP","vault":"UP"}
```

* Meanwhile you can check the traffic in the mitmproxy VM webpage, [192.168.20.10:8081](http:192.168.20.10:8081) in your browser

![image](https://user-images.githubusercontent.com/85481359/132823624-78c0fb2c-0f98-4cec-b40f-b952befa6031.png)


* Once TFE is fully started, visit [192.168.20.11.nip.io:8800](http:192.168.20.11.nip.io:8800) in your browser

![image](https://user-images.githubusercontent.com/85481359/132824324-6be8590f-ca89-4c25-8982-0f2f2be39db1.png)

* Enter *Password!* to unlock the console

![image](https://user-images.githubusercontent.com/85481359/132824452-17c54cf3-32d5-4cad-98f1-2dcd5dda0eb4.png)

* Enjoy

![image](https://user-images.githubusercontent.com/85481359/132824704-0926de15-cde4-4821-af19-9ae59eb9fa63.png)

### Cleanup

```
vagrant destroy -f
```

_sample_:

```
vagrant destroy -f
==> tfe: Forcing shutdown of VM...
==> tfe: Destroying VM and associated drives...
==> mitmproxy: Forcing shutdown of VM...
==> mitmproxy: Destroying VM and associated drives...
```
