#!/bin/bash

IFS=$'\n'

SEARCH_STRING="minha-string"

for i in $(cat secrets-list.txt); do
    NS=$(echo $i | awk '{print $1}')
    SECRET=$(echo $i | awk '{print $2}')
    echo "Verificando secret: $SECRET no namespace: $NS"

    secret_data=$(kubectl get secret $SECRET -n $NS -o jsonpath='{.data}')
    if echo "$secret_data" | grep "$SEARCH_STRING"; then
        echo "String '$SEARCH_STRING' encontrada na secret $SECRET no namespace $NS"
        kubectl get secret $SECRET -n $NS -o yaml > dump2/$SECRET.yaml
        echo "Dump da secret $SECRET salvo como $SECRET.yaml"    
    else
        echo "String '$SEARCH_STRING' não encontrada na SECRET $SECRET no NS $NS"                  
    fi 
done
