# Script to check for virus on Linux

## 🚀 Getting Started

This script uses Clamav to scan and remove virus on Linux.


### 📋 Prerequisites
Compatible with Debian-based Linux distribution.

## 📄 License

This project is under license (GNU General Public License v3.0. - see the file [LICENSE.md](https://github.com/rovanni/Script_antivirus_Linux/blob/main/LICENSE. for details.

### It works for the following options:

1. Scanning and removing viruses from home folder files up to 5MB.
2. Scanning and removing viruses from the basic home folder.
3. Scanning and removing viruses from full root folder up to 5MB files.
4. Install Clamav Antivirus
5. Open latest virus scan report
6. Exit the program

### What each option does:

1. The first option is a quick scan, it does recursive searches in the user's "home" folder, and removes the viruses found. In this option, files up to 5MB are scanned, if any virus is found, it is removed and a report is generated.
Parameters used:
sudo clamscan --recursive /home/ --max-filesize=5M --bell --remove=yes -i --bytecode=yes --bytecode-timeout=5000 --multiscan
 >> /var/log/clamav/relscan.log

2. The second option is a scan that makes recursive searches in the user's "home" folder, and removes the viruses found. In this option, all files are scanned with no size limit, if any virus is found, it is removed and a report is generated.
Parameters used:
sudo clamscan --recursive /home/ --bell --remove=yes -i --bytecode=yes --bytecode-timeout=5000 --multiscan >> /var/log/clamav/relscan.log

3. The third option is a check of the HD where Linux is installed, it makes recursive searches in the HD folder, and removes the viruses found, in this option files of up to 5MB are checked, if any virus is found, it is removed and a report.
Parameters used:
sudo clamscan --recursive / --bytecode=yes --bytecode-timeout=5000 --exclude-dir="^/sys" --max-filesize=5M --bell --remove=yes -i --multiscan > > /var/log/clamav/relscan.log

4. The fourth option, server to install Clamav if it is not installed, after installing and updating the Antivirus database.
Parameters used:
sudo apt-get update && sudo apt-get install clamav clamav-daemon clamav-freshclam clamtk -y
sudo /etc/init.d/clamav-freshclam stop
sudo /usr/bin/freshclam -v
sudo /etc/init.d/clamav-freshclam start

5. The fifth option, I opened the latest virus scan report.
Parameters used:
cat /var/log/clamav/relscan.log

6. The sixth option exits the program.

## ✒️ Author

Luciano R. Nascimento


#  Script para verificar vírus no Linux (Versão em português)

## 🚀 Começando

Esse script utiliza o Clamav para verificar e remover vírus no Linux.


### 📋 Pré-requisitos
Compatível com distribuição Linux baseadas em Debian.

## 📄 Licença

Este projeto está sob a licença (GNU General Public License v3.0. - veja o arquivo [LICENSE.md](https://github.com/rovanni/Script_antivirus_Linux/blob/main/LICENSE. para detalhes.

### Serve para as seguintes opções:

1. Verificando e removendo vírus da pasta home arquivos até 5MB.
2. Verificando e removendo vírus da pasta home básica.
3. Verificando e removendo vírus da pasta raiz completa até arquivos 5MB.
4. Instalar Antivírus Clamav
5. Abrir ultimo relatório de verificação de vírus
6. Sair do programa

###  O que cada opção faz:

1. A primeira opção, é uma verificação rápida, faz buscas recursivas na pasta do usuário "home", e remove os vírus encontrados, nesta opção são verificados os arquivos de até 5MB, caso encontre algum vírus é removido e gerado um relatório.
Parâmetros utilizados:
		sudo clamscan --recursive /home/ --max-filesize=5M --bell --remove=yes -i --bytecode=yes --bytecode-timeout=5000 --multiscan
 >> /var/log/clamav/relscan.log

2. A segunda opção, é uma verificação faz buscas recursivas na pasta do usuário "home", e remove os vírus encontrados, nesta opção são verificados os todos os arquivos sem limite de tamanho, caso encontre algum vírus é removido e gerado um relatório.
Parâmetros utilizados:
	sudo clamscan --recursive /home/ --bell --remove=yes -i --bytecode=yes --bytecode-timeout=5000 --multiscan >> /var/log/clamav/relscan.log

3. A terceira opção, é uma verificação do HD aonde o Linux esta instalado, faz buscas recursivas nas pasta do HD, e remove os vírus encontrados, nesta opção são verificados os arquivos de até 5MB, caso encontre algum vírus é removido e gerado um relatório.
Parâmetros utilizados:
	sudo clamscan --recursive / --bytecode=yes --bytecode-timeout=5000 --exclude-dir="^/sys" --max-filesize=5M --bell --remove=yes -i --multiscan >> /var/log/clamav/relscan.log

4. A quarta opção, server para instalar o Clamav caso ele não esteja instalado, apos a instalação e feita atualização da base dados do Antivírus.
Parâmetros utilizados:
	sudo apt-get update && sudo apt-get install clamav clamav-daemon clamav-freshclam clamtk -y
	sudo /etc/init.d/clamav-freshclam stop
	sudo /usr/bin/freshclam -v
	sudo /etc/init.d/clamav-freshclam start	

5. A quinta opção, abri ultimo relatório de verificação de vírus.
Parâmetros utilizados:
	cat /var/log/clamav/relscan.log

6. A sexta opção sai do programa.

## ✒️ Autor

Luciano R. Nascimento