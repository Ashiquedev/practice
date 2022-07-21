Installing Kubernetes
=====================


## KOPS
----

* prerequisites
    * Domain Name - aashiqui.shop
    * AWS Account
    * S3 Bucket & Route53 Domain Integration
    * Deploy a Mgmt Server which holds all scripts.
    * KOPS Binary(K8S Cluster Mgmt) & KUBECTL Binary(K8S Cluster Ops)
    * SSH Public & Private Keys
    * AWS CLI and AWS Access/Secret Key


* Kubectl:
```
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
sudo apt-get update
sudo apt-get install -y kubectl
```

* kops repo

```
curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64

chmod +x kops-linux-amd64

sudo mv kops-linux-amd64 /usr/local/bin/kops
```

* aws cli
```
apt install awscli
aws configure
```
* cluster creation
```
kops create cluster --name=aashiqui.shop --state=s3://aashiqui.shop --zones=ap-south-1a --node-count=2 --node-size=t2.micro --master-size=t2.small --master-volume-size 20 --node-volume-size 10 --dns-zone=aashiqui.shop –yes
```

```
vi .bashrc
# KOPS_STATE_STORE s3://aashiqui.shop
# 
# 
# source .bashrc
```


* command to get the cluster details: `kops get cluster --state s3://aashiqui.shop`

```
NAME            CLOUD   ZONES
aashiqui.shop   aws     ap-south-1a

```
* command to know the details of master and nodes: `kops get ig --name aashiqui.shop --state s3://aashiqui.shop`

```
output:
NAME                    ROLE    MACHINETYPE     MIN     MAX     ZONES
master-ap-south-1a      Master  t2.small        1       1       ap-south-1a
nodes-ap-south-1a       Node    t2.micro        2       2       ap-south-1a
```

* command to edit the configuration of master: `kops edit ig --name=aashiqui.shop master-ap-south-1a --state s3://aashiqui.shop`

```
output:
# Please edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
apiVersion: kops.k8s.io/v1alpha2
kind: InstanceGroup
metadata:
  creationTimestamp: "2022-07-18T07:53:02Z"
  labels:
    kops.k8s.io/cluster: aashiqui.shop
  name: master-ap-south-1a
spec:
  image: 099720109477/ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20220615
  instanceMetadata:
    httpPutResponseHopLimit: 3
    httpTokens: required
  machineType: t2.small
  manager: CloudGroup
  maxSize: 1
  minSize: 1
  nodeLabels:
    kops.k8s.io/instancegroup: master-ap-south-1a
  role: Master
  rootVolumeSize: 20
  subnets:
  - ap-south-1a

```

* command to edit the configuration of nodes: `kops edit ig --name=aashiqui.shop nodes-ap-south-1a  --state s3://aashiqui.shop`

```
output:
# Please edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
apiVersion: kops.k8s.io/v1alpha2
kind: InstanceGroup
metadata:
  creationTimestamp: "2022-07-18T07:53:02Z"
  labels:
    kops.k8s.io/cluster: aashiqui.shop
  name: nodes-ap-south-1a
spec:
  image: 099720109477/ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20220615
  instanceMetadata:
    httpPutResponseHopLimit: 1
    httpTokens: required
  machineType: t2.micro
  manager: CloudGroup
  maxSize: 2
  minSize: 2
  nodeLabels:
    kops.k8s.io/instancegroup: nodes-ap-south-1a
  role: Node
  rootVolumeSize: 10
  subnets:
  - ap-south-1a
```
* update the cluster: `kops update cluster --name aashiqui.shop --yes --state  s3://aashiqui.shop`
* rolling update: `kops rolling-update cluster  --name aashiqui.shop --yes --state  s3://aashiqui.shop –cloudonly`
* delete the cluster: `kops delete cluster --name=aashiqui.shop --state s3://aashiqui.shop --yes`



## kubeadm
* installing docker:
```
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

```
* installing cri-dockerd


* for install reference pls [click here](https://github.com/Mirantis/cri-dockerd)

```
# Run these commands as root

sudo -i 

###Install GO###

wget https://storage.googleapis.com/golang/getgo/installer_linux

chmod +x ./installer_linux

./installer_linux

source ~/.bash_profile

git clone https://github.com/Mirantis/cri-dockerd.git

cd cri-dockerd

mkdir bin

go get && go build -o bin/cri-dockerd

mkdir -p /usr/local/bin

install -o root -g root -m 0755 bin/cri-dockerd /usr/local/bin/cri-dockerd

cp -a packaging/systemd/* /etc/systemd/system

sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service

systemctl daemon-reload

systemctl enable cri-docker.service

systemctl enable --now cri-docker.socket
```
* install kubelet, kubeadm and kubectl

```
cd 

sudo apt-get update

sudo apt-get install -y apt-transport-https ca-certificates curl

sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update

sudo apt-get update

sudo apt-get install -y kubelet kubeadm kubectl

sudo apt-mark hold kubelet kubeadm kubectl


```
* settingup flannel as kubernetes network CNI
```
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
```


* kubeadm cluster setup ` kubeadm init --pod-network-cidr=10.244.0.0/16 --cri-socket unix:///var/run/cri-dockerd.sock `

```
output:
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 172.31.4.91:6443 --token zecho3.g2tirg5lq0t8vg35 \
        --discovery-token-ca-cert-hash sha256:856e0c6cf145f10af493a155f432f36519916b55809a1adcc87bd0275635ec2b --cri-socket unix:///var/run/cri-dockerd.sock
```

* To run kubernetes as a non root user on control plane

```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

MINIKUBE:
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl conntrack
curl https://get.docker.com | bash
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube
sudo mv minikube /usr/local/bin
set NO_PROXY=localhost,127.0.0.1,10.96.0.0/12,192.168.99.1/24,192.168.39.0/24

minikube start --vm-driver=none
