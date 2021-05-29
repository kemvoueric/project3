#! /bin/bash

B=$(kubectl  -n metallb-system  get po  |awk -F"-" '{print $2}' |tail -1)

if
        [[ $B  == speaker ]]
then
echo "metallb is already installed"
kubectl  -n metallb-system  get all
else
kubectl apply -f   ~/kubeadm-ansible/roles/metallb/files/metallb_namespace.yml
kubectl apply -f https://raw.githubusercontent.com/google/metallb/master/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl create -f  ~/kubeadm-ansible/roles/metallb/files/metallb_configmap.yml
sleep 60
echo "done installing  MetalLB"
kubectl -n metallb-system get all
fi
