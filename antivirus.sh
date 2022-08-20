#!/bin/bash
###################################################################
# NOME:				antivirus.sh
# VERSÃO:				1.1
# DESCRIÇÃO:			Script para verificar e removendo vírus Linux 			
# DATA DA CRIAÇÃO:	14/08/2022
# ESCRITO POR:		Luciano R. Nascimento
# E-MAIL:				rovanni@gmail.com 			
# DISTRO:	Linux baseadas em Debian				
# LICENÇA:			GPLv3 			
# PROJETO:			https://github.com/rovanni/Script_antivirus_Linux
###################################################################

function pause(){
###################################################################
# Função para criar uma pause
###################################################################
	read -s -n 1 -p "Pressione qualquer tecla para continuar . . ."
	echo ""
}	

function atualizar(){
###################################################################
# Função para atualizar a base de dados do antivírus
###################################################################
	################# Atualizar Base dados Antivírus Clamav ###############################
	echo "Atualizando base de dados do antivírus. Por Favor Aguarde!!!................................";		
	echo ""	
	sudo /etc/init.d/clamav-freshclam stop
	sudo /usr/bin/freshclam -v
	sudo /etc/init.d/clamav-freshclam start
	echo ""	
	echo "Base de dados do antivírus atualizada!!!....................................................";	
	echo ""		
}

function cabecalho(){
###################################################################
# Função para atualizar a base de dados do antivírus
###################################################################
	sudo chmod -R 777 /var/log/clamav/		#Permissão de gravar na pasta
	echo >>/var/log/clamav/relscan.log		#Grava um espaço em branco dentro arquivo
	echo >>/var/log/clamav/relscan.log		#Grava um espaço em branco dentro arquivo		
	echo ========================================================= >>/var/log/clamav/relscan.log	#imprime uma linha		
	echo ----------- Relatório de Verificação de Vírus ----------- >>/var/log/clamav/relscan.log	#Grava cabeçalho
	data=`date +%d/%m/%Y-%H:%M:%S`			#Armazena dia e hora na variavel data
	echo Relatório gerado dia: ${data}  >>/var/log/clamav/relscan.log	#Grava data e hora atual dentro arquivo
	#echo >>/var/log/clamav/relscan.log		#Grava um espaço em branco dentro arquivo	
}

function encerramento(){
###################################################################
# Função para atualizar a base de dados do antivírus
###################################################################
	data=`date +%d/%m/%Y-%H:%M:%S`			#Armazena dia e hora na variável data
	echo Verificação encerada: ${data}  >>/var/log/clamav/relscan.log	#Grava data e hora atual dentro arquivo		
	echo ========================================================= >>/var/log/clamav/relscan.log	#imprime uma linha
	echo ""	
	echo "Verificação concluída com sucesso.................................................[ OK ]";
	echo "Relatorio gerado em: /var/log/clamav/relscan.log..................................[ OK ]";
	echo "Dúvidas de comandos do Clamscan digite: clamscan --help.................................";		
	cat /var/log/clamav/relscan.log
	echo ""	
	pause	
}

x="antivirus"
menu ()
{
while true $x != "antivirus"
do
clear
echo "==============================================================================="
echo "Script to help with virus removal!"
echo "In all check options the Database,"
echo "from Clamav Antivirus and updated before scanning."
echo "Created by: Luciano R.N."
echo ""
echo "1)Quick scan on user's home folder, performs recursive searches using multiple simultaneous threads."
echo ""
echo "2)Fast HD scan, performs recursive searches using multiple simultaneous threads."
echo ""
echo "3)Check and remove viruses from home folder all files."
echo ""
echo "4)Scans and removes viruses from the root folder, less system files."
echo ""
echo "5)Install Clamav Antivirus."
echo ""
echo "6)Open latest virus scan report."
echo ""
echo "7)Exit the program."
echo ""
echo "==============================================================================="
echo "Enter the desired option:"
read x
echo "Option informed ($x)"
echo "==============================================================================="

case "$x" in

	1)
		################# Atualizar Base dados Antivírus Clamav ###############################
		atualizar ##chama função atualizar	
		####################### Verificar e remover vírus home ###############################
		echo
		echo "Verificando e removendo vírus da pasta home. Por Favor Aguarde!!!.......................";
		echo		
		cabecalho ##chama função cabeçalho
		sudo clamdscan --multiscan --fdpass --recursive /home/ --remove=yes -i --bytecode=yes --bytecode-timeout=5000 --quiet >> /var/log/clamav/relscan.log	#Verifica e remove os virus e grava o relatoria dentro do arquivo
		encerramento ##chama função encerramento

echo "================================================"
;;
	2)
		################# Atualizar Base dados Antivírus Clamav ###############################
		atualizar ##chama função atualizar	
		####################### Verificar e remover virus HD ###############################
		echo
		echo "Verificando e removendo vírus da pasta /. Por Favor Aguarde!!!.......................";
		echo
		cabecalho ##chama função cabeçalho
		sudo clamdscan --multiscan --fdpass / --remove=yes -i --bytecode=yes --bytecode-timeout=5000 --exclude-dir="^/sys" --quiet >> /var/log/clamav/relscan.log	#Verifica e remove os vírus e grava o relatoria dentro do arquivo
		encerramento ##chama função encerramento

echo "================================================"
;;
	3)
		################# Atualizar Base dados Antivírus Clamav ###############################
		atualizar ##chama função atualizar	
		####################### Verificar e remover vírus home ###############################
		echo
		echo "Verificando e removendo vírus da pasta home. Por Favor Aguarde!!!.......................";
		echo		
		cabecalho ##chama função cabeçalho
		sudo clamscan --recursive /home/ --bell --remove=yes -i --bytecode=yes --bytecode-timeout=5000 
 >> /var/log/clamav/relscan.log	#Verifica e remove os virus e grava o relatoria dentro do arquivo
		encerramento ##chama função encerramento

echo "================================================"
;;
	4)
		################# Atualizar Base dados Antivírus Clamav ###############################
		atualizar ##chama função atualizar	
		####################### Verificar e remover virus HD ###############################
		echo
		echo "Verificando e removendo vírus da pasta /. Por Favor Aguarde!!!.......................";
		echo
		cabecalho ##chama função cabeçalho
		sudo clamscan --recursive / --bytecode=yes --bytecode-timeout=5000 --exclude-dir="^/sys" --bell --remove=yes -i >> /var/log/clamav/relscan.log	#Verifica e remove os vírus e grava o relatoria dentro do arquivo
		encerramento ##chama função encerramento

echo "================================================"

;;
	5)
		echo "Instalando Antivírus..."
		sudo apt-get update && sudo apt-get install clamav clamav-daemon clamav-freshclam clamtk -y
		sudo /etc/init.d/clamav-freshclam stop
		sudo /usr/bin/freshclam -v
		sudo /etc/init.d/clamav-freshclam start		
		echo ""
		echo "Antivírus Instalado!"
		sleep 5

echo "================================================"
;;
	6)
		echo "Abrir ultimo relatório de verificação de vírus..."
		cat /var/log/clamav/relscan.log
		echo ""
		echo ""
		echo ""		
		pause	

echo "================================================"
;;
	7)
		echo "Saindo..."
		sleep 1
		clear;
		exit 1		
echo "================================================"
;;
	*)
        echo "Opção inválida!"
esac
done

}
menu
