#! /bin/bash
A=$(kubectl get configmap kube-proxy -n kube-system -o yaml |head -33 |grep true |awk '{print $2}')
if 
  [[ $A == true ]]
  then 
  echo  "it looks good"
  else
kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e "s/strictARP: false/strictARP: true/" | kubectl apply -f - -n kube-system
  fi 
  
