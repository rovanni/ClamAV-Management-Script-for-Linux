#  Script para verificar vírus no Linux


Esse script utiliza o Clamav para verificar e remover vírus no Linux, compatível com distribuição Linux baseadas em Debian.
LICENÇA: GPLv3 

Serve para as seguintes opções:

1)Verificando e removendo vírus da pasta home arquivos até 5MB.

2)Verificando e removendo vírus da pasta home básica.

3)Verificando e removendo vírus da pasta raiz completa até arquivos 5MB.

4)Instalar Antivírus Clamav

5)Abrir ultimo relatório de verificação de vírus

6)Sair do programa

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