#!/bin/sh
# Last Update: November 25 2020
# Author: Gabriel Bezerra
# Email gabriel.bezerra@digivox.com.br

<< 'CHANGELOG'
  1.0 - 10/07/2019 [ Author: Gabriel Bezerra ]
            * Initial release
            * Função supas
            * Aliasse principais
CHANGELOG

# Para executar eval "$(curl -s caminho do repo)"
# Função principal, listar todas as funções disponíveis
function supas (){
echo -e '
                          ____  _       _                
                        |  _ \(_) __ _(_)_   _______  __                                                                                               
                        | | | | |/ _` | \ \ / / _ \ \/ /                                                                                               
                        | |_| | | (_| | |\ V / (_) >  <                                                                                                
                        |____/|_|\__, |_| \_/ \___/_/\_\                                                                                               
                                 |___/                                      
'
echo -e "\nAmbiente de Suporte :: Lista de Funcoes\n======================================="
echo -e "\nSIPSERVER\n=======================================\n"

echo -e "showreg\t\t\t\t->\tMostra ramais registrados"
echo -e "memcache\t\t\t->\tExecuta memcache flush"
echo -e "reloadxml\t\t\t->\tExecuta reloadxml"
echo -e "unity-services\t\t\t->\tVerifica servicos unity"

echo -e "\nSERVER\n=======================================\n"

echo -e "verifywav\t\t\t->\tVerifica arquivos wav.tar.gz > 10MB"
echo -e "removewav\t\t\t->\tRemove arquivos wav.tar.gz > 10MB"


echo -e "\nSugestoes podem ser sugeridas através do e-mail do Suporte\n" ;}

supas;

function showreg(){
fs_cli -x "show registrations";
}

function memcache(){
fs_cli -x "memcache flush";
}

function reloadxml(){
fs_cli -x "reloadxml";
}

function verifywav(){
dir=/ 
cd $dir
find -name "backup-gravacoes-wav*" -size "+10M" -exec du -sh {} \;
}

function removewav(){
dir=/ 
cd $dir
for i in `find -name "backup-gravacoes-wav*" -size "+10M" -exec du -sh {} \;`; do rm -rf $i; done
}

function unity-services(){
unity=`netstat -tupnl | grep 9001 | wc -l`
fs=`netstat -tupnl | grep 8021 | wc -l`
ivr=`netstat -tupnl | grep 8085 | wc -l`
integration=`netstat -tupnl | grep 8080 | wc -l`

if  [ $unity == "1" ] && [ $fs == "1" ] && [ $ivr == "1" ] && [ $integration == "1" ]
then
        echo " UNITY, FS, IVR e INTEGRATION estão UP" 
elif [ $fs == "0" ]
then
        echo "FS DOWN"
elif [ $integration == "0" ]
then
        echo "INTEGRATION DOWN"
elif [ $unity == "0" ]
then
        echo "UNITY DOWN"
elif [ $ivr == "0" ]
then
        echo "IVR DOWN"
fi
}