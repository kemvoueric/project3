A=busybox
B=centos
C=mariadb
D=mongo
E=node
F=postgres
G=redis
H=ubuntu
I=mysql
J=registry


for a  in  $A  $B  $C  $D  $E  $F   $G    $H   $I $J
do
docker docker load <  ${a}.tar 
done

docker run -d -p 5000:5000 --restart=always --name local-registry registry
for b  in $A  $B  $C  $D  $E  $F   $G    $H   $I   $J
do
docker push docker.local:5000/${b}
done
