# Script to check for virus on Linux

## 🚀 Getting Started

This script uses Clamav to scan and remove virus on Linux.


### 📋 Prerequisites
Compatible with Debian-based Linux distribution.

## 📄 License

This project is under license (GNU General Public License v3.0. - see the file [LICENSE.md](https://github.com/rovanni/Script_antivirus_Linux/blob/main/LICENSE) for details.

### It works for the following options:

1. Quick scan on user's home folder, performs recursive searches using multiple simultaneous threads.
2. Fast HD scan, performs recursive searches using multiple simultaneous threads.
3. Scan and remove viruses from home folder all files.
4. Scans and removes viruses from the root folder.
5. Install Clamav Antivirus.
6. Open latest virus scan report.
7. Close the program.

### What each option does:

1. The first option is a quick scan using several simultaneous threads, performs recursive searches in the user's "home" folder, and removes the viruses found, if any virus is found, it is removed and a report is generated.
Parameters used:
	sudo clamdscan --multiscan --fdpass --recursive /home/ --remove=yes -i --bytecode=yes --bytecode-timeout=5000 --quiet >> /var/log/clamav/relscan.logclamav/relscan.log

2. The second option is a quick scan using several simultaneous threads, it performs recursive searches on the HD, and removes the viruses found, in this option all files are scanned with no size limit, it does not scan system files if it finds any virus is removed and a report is generated.
Parameters used:
	sudo clamdscan --multiscan --fdpass / --remove=yes -i --bytecode=yes --bytecode-timeout=5000 --exclude-dir="^/sys" --quiet >> /var/log/clamav/relscan.log

3. The third option is a scan of the user's "home" folder, it makes recursive searches in the "home" folder, and removes the viruses found, if it finds any viruses it is removed and a report is generated.
Parameters used:
	sudo clamscan --recursive /home/ --bell --remove=yes -i --bytecode=yes --bytecode-timeout=5000 >> /var/log/clamav/relscan.log
 
4. The fourth option is a check of the HD where Linux is installed, it does recursive searches in the HD folder, and removes the viruses found, if it finds any virus is removed and a report is generated.
Parameters used:
sudo clamscan --recursive / --bytecode=yes --bytecode-timeout=5000 --exclude-dir="^/sys" --bell --remove=yes -i >> /var/log/clamav/relscan. log

5. The fifth option, installs Clamav if it is not installed, after installing and updating the Antivirus database.
Parameters used:
	sudo apt-get update && sudo apt-get install clamav clamav-daemon clamav-freshclam clamtk -y
	sudo /etc/init.d/clamav-freshclam stop
	sudo /usr/bin/freshclam -v
	sudo /etc/init.d/clamav-freshclam start

6. The sixth option, I opened the latest virus scan report.
Parameters used:
	cat /var/log/clamav/relscan.log

7. The seventh option closes the program.
Parameters used:
	exit 1

## ✒️ Author

Luciano R. Nascimento


#  Script para verificar vírus no Linux (Versão em português)

## 🚀 Começando

Esse script utiliza o Clamav para verificar e remover vírus no Linux.


### 📋 Pré-requisitos
Compatível com distribuição Linux baseadas em Debian.

## 📄 Licença

Este projeto está sob a licença (GNU General Public License v3.0. - veja o arquivo [LICENSE.md](https://github.com/rovanni/Script_antivirus_Linux/blob/main/LICENSE) para detalhes.

### Serve para as seguintes opções:

1. Verificação rápida na pasta do usuário home, realiza buscas recursivas utilizando vários threads simultâneos.
2. Verificação rápida no HD, realiza buscas recursivas utilizando vários threads simultâneos.
3. Verifica e remove vírus da pasta home todos arquivos.
4. Verifica e remove vírus da pasta raiz.
5. Instalar Antivírus Clamav.
6. Abrir último relatório de verificação de vírus.
7. Fecha o programa.

###  O que cada opção faz:

1. A primeira opção, é uma verificação rápida utilizando vários threads simultâneos, realiza buscas recursivas na pasta do usuário "home", e remove os vírus encontrados, caso encontre algum vírus é removido e gerado um relatório.
Parâmetros utilizados:
	sudo clamdscan --multiscan --fdpass --recursive /home/ --remove=yes -i --bytecode=yes --bytecode-timeout=5000 --quiet >> /var/log/clamav/relscan.log

2. A segunda opção, é uma verificação rápida utilizando vários threads simultâneos, realiza buscas recursivas no HD, e remove os vírus encontrados, nesta opção são verificados os todos os arquivos sem limite de tamanho, não verifica arquivos do sistema, caso encontre algum vírus é removido e gerado um relatório.
Parâmetros utilizados:
	sudo clamdscan --multiscan --fdpass / --remove=yes -i --bytecode=yes --bytecode-timeout=5000 --exclude-dir="^/sys" --quiet >> /var/log/clamav/relscan.log

3. A terceira opção, é uma verificação da pasta do usuário "home", faz buscas recursivas nas pasta do "home", e remove os vírus encontrados, caso encontre algum vírus é removido e gerado um relatório.
Parâmetros utilizados:
	sudo clamscan --recursive /home/ --bell --remove=yes -i --bytecode=yes --bytecode-timeout=5000 
 >> /var/log/clamav/relscan.log
 
4. A quarta opção, é uma verificação do HD aonde o Linux esta instalado, faz buscas recursivas nas pasta do HD, e remove os vírus encontrados, caso encontre algum vírus é removido e gerado um relatório.
Parâmetros utilizados:
	sudo clamscan --recursive / --bytecode=yes --bytecode-timeout=5000 --exclude-dir="^/sys" --bell --remove=yes -i >> /var/log/clamav/relscan.log

5. A quinta opção, instala o Clamav caso ele não esteja instalado, apos a instalação e feita atualização da base dados do Antivírus.
Parâmetros utilizados:
	sudo apt-get update && sudo apt-get install clamav clamav-daemon clamav-freshclam clamtk -y
	sudo /etc/init.d/clamav-freshclam stop
	sudo /usr/bin/freshclam -v
	sudo /etc/init.d/clamav-freshclam start	
	
6. A sexta opção, abri ultimo relatório de verificação de vírus.
Parâmetros utilizados:
	cat /var/log/clamav/relscan.log

7. A sétima opção fecha o programa.
Parâmetros utilizados:
	exit 1

## ✒️ Autor

Luciano R. Nascimento