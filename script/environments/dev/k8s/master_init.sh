#!/bin/bash

USER_HOME=/home/ec2-user

set -e

### 필수: Swap 비활성화
echo "Disabling swap..."
sudo swapoff -a
sudo sed -i '/swap/d' /etc/fstab

### SELinux Permissive 설정
echo "Setting SELinux to permissive mode..."
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config

### Docker 설치
echo "Installing Docker..."
sudo dnf update
sudo dnf install docker -y
sudo systemctl start docker
sudo systemctl enable --now docker

# Docker systemd cgroup 드라이버 설정
echo "Configuring Docker cgroup driver..."
sudo mkdir -p /etc/docker
sudo cat <<EOF > /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF

echo "Restarting Docker service..."
sudo systemctl daemon-reexec
sudo systemctl restart docker

### Kubernetes 저장소 설정
echo "Setting up Kubernetes repository..."
sudo cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/repodata/repomd.xml.key
EOF

### Kubernetes 설치
echo "Installing Kubernetes components..."
sudo dnf install -y kubelet kubeadm kubectl
sudo systemctl enable kubelet
sudo kubeadm version

sudo echo "127.0.0.1 $(hostname)" | sudo tee -a /etc/hosts

### kubeadm init (Flannel 기준 Pod CIDR)
echo "Initializing Kubernetes cluster with kubeadm..."
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# kubeconfig 설정
echo "Configuring kubeconfig for the current user..."
mkdir -p $USER_HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $USER_HOME/.kube/config
sudo chown $(id -u):$(id -g) $USER_HOME/.kube/config

echo "Restarting kubelet service..."
sudo systemctl restart kubelet

# Flannel CNI 적용
echo "Applying Flannel CNI..."
curl -LO https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
sudo KUBECONFIG=$USER_HOME/.kube/config kubectl apply -f kube-flannel.yml
sudo rm kube-flannel.yml
