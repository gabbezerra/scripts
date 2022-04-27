#!/bin/bash
#executado dentro do diretorio onde estão os ingress a serem alterados
#Susbstitui linhas do rewrite e path do bloco de dev
for i in `ls -1 ../ings-dev-bkp/` ; do

end1=$(cat ../ings-dev-bkp/$i | awk '/rewrite-target/{print $2}') ; 
echo $end1
    if [ $end1 == "/" ] ; then
        sed -i -r 's/(.*rewrite-target: .*)/&$2/' ../ings-dev-bkp/$i
    else
        sed -i -r 's/(.*rewrite-target: .*)/&\/$2/' ../ings-dev-bkp/$i    
    fi
sed -i -r '/- host: (.*dev.*)/,/pathType:/ s/(path: .*)/&\(\/\|\$\)\(\.\*\)/' ../ings-dev-bkp/$i ; 
done

