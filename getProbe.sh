#!/bin/bash

#Segrega ingress url e verifica probes em seus respectivos pods. Ao Final valida conexao com CURL
ENV="uat"
echo "NAMESPACE;INGRESS;URL;PROBE;URL_PROBE;STATUS"
IFS=$'\n'
for i in $(kubectl get ingress -A| awk '{print $1,$2,$4}' | tail -n +2| grep "$ENV"); do 
    NS=$(echo $i | awk '{print $1}')
    ING=$(echo $i | awk '{print $2}')
    URL2=$(echo $i | awk '{print $3}'| tr "," "\n"| grep "$ENV")
    PROBE=$(kubectl get deployments -n "$NS" "$ING" -o jsonpath="{.spec.template.spec.containers[*].readinessProbe.httpGet.path}" 2>/dev/null || echo "Nao encontrado")
    URL_PROBE="http://$URL2/$ING/$PROBE"
    STATUS=$(curl -sI "$URL_PROBE" | grep -i ^HTTP/ | awk '{print $2}')
    echo -e "$NS;$ING;$URL2;$PROBE;$URL_PROBE;$STATUS;"
     
done
