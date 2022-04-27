#!/bin/bash
#DATA CRIACAO:17/01/22
#SCRIPT PARA EXTRAIR VERSAO DO APIVERSION DOS INGRESS

#ANTES DE EXECUTAR E NECESSARIO ESTAR LOGADO NO CLUSTER QUE SERA ANALISADO

# NEW_VERSION="networking.k8s.io/v1"
# OLD_VERSION="networking.k8s.io/v1"

#BLOCO PARA VERIFICAR A VERSAO DA API

echo "NAMESPACE;INGRESS;VERSION"
IFS=$'\n'
for i in $(kubectl get ingress -A | awk '{print $1,$2}' | tail -n +2); do 
    NS=$(echo $i | awk '{print $1}')
    ING=$(echo $i | awk '{print $2}')
    echo -n "$NS;$ING;" 
    kubectl get ingress -n $NS $ING -o yaml > ../ings-dev-bkp/$ING.yaml
done

#BLOCO PARA PRINTAR EM TELA A VERSAO FORA DA CORRETA E TOMAR ACAO CASO NECESSARIO

# for a in $(cat all_ingress.csv | grep -v "$OLD_VERSION"); do
#     NS=$(echo $a | awk -F ";" '{print $1}')
#     ING=$(echo $a | awk -F ";" '{print $2}')
#     VERSION=$(echo $a | awk -F ";" '{print $3}')    
#     #kubectl get ingress -n $NS $ING -o yaml |grep "^apiVersion" | awk '{print $2}'
# done
