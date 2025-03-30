#!/bin/bash
###################################################################
# NOME:            clamav_menu.sh
# VERSÃO:          2.0
# DESCRIÇÃO:       Script de gerenciamento do ClamAV para Ubuntu Desktop
# DATA:            14/08/2022 (atualizado em 20/05/2024)
# AUTOR:           Luciano R. Nascimento
# EMAIL:           rovanni@gmail.com
# LICENÇA:         GPLv3
# PROJETO:         https://github.com/rovanni/ClamAVManagementScriptLinux/
###################################################################

# Configurações
LOG_DIR="/var/log/clamav"
LOG_FILE="$LOG_DIR/relscan.log"
AUTO_SCAN_LOG="$LOG_DIR/auto_scan.log"

# Funções auxiliares
function pause() {
    read -r -s -n 1 -p "Pressione qualquer tecla para continuar..."
    echo
}

function atualizar_db() {
    echo "Atualizando base de dados do antivírus..."
    sudo freshclam -v
    pause
}

function cabecalho() {
    sudo mkdir -p "$LOG_DIR"
    sudo chmod 755 "$LOG_DIR"
    sudo touch "$LOG_FILE"
    sudo chmod 644 "$LOG_FILE"
    
    echo "=======================================================" | sudo tee -a "$LOG_FILE"
    echo "           RELATÓRIO DE VERIFICAÇÃO DE VÍRUS           " | sudo tee -a "$LOG_FILE"
    echo "Data/hora inicial: $(date +'%d/%m/%Y %H:%M:%S')" | sudo tee -a "$LOG_FILE"
    echo "-------------------------------------------------------" | sudo tee -a "$LOG_FILE"
}

function encerramento() {
    echo "-------------------------------------------------------" | sudo tee -a "$LOG_FILE"
    echo "Data/hora final: $(date +'%d/%m/%Y %H:%M:%S')" | sudo tee -a "$LOG_FILE"
    echo "=======================================================" | sudo tee -a "$LOG_FILE"
    echo "Relatório salvo em: $LOG_FILE"
    echo "Visualizar relatório completo? (S/n)"
    read -r resposta
    if [[ "$resposta" =~ ^[Ss]$ ]]; then
        less "$LOG_FILE"
    fi
    pause
}

function verificar_diretorio() {
    local diretorio="$1"
    local parametros="$2"
    
    cabecalho
    echo "Tipo de verificação: $3" | sudo tee -a "$LOG_FILE"
    echo "Diretório verificado: $diretorio" | sudo tee -a "$LOG_FILE"
    
    sudo clamscan $parametros "$diretorio" | sudo tee -a "$LOG_FILE"
    encerramento
}

function agendar_verificacao() {
    echo "Agendamento de verificação automática"
    echo "Digite o horário (formato HH:MM):"
    read -r horario
    echo "Digite o diretório a ser verificado:"
    read -r diretorio

    # Validar entrada do horário
    if ! [[ "$horario" =~ ^[0-9]{2}:[0-9]{2}$ ]]; then
        echo "Formato de horário inválido!"
        pause
        return
    fi

    # Criar entrada no cron
    local cron_job="$horario * * * * root clamscan --recursive $diretorio --bell --remove=yes -i --log=$AUTO_SCAN_LOG"
    echo "$cron_job" | sudo tee -a /etc/crontab > /dev/null
    
    echo "Verificação agendada diariamente às $horario para o diretório $diretorio"
    pause
}

# Menu principal
function menu() {
    while true; do
        clear
        echo "===================================================================="
        echo "                  MENU DE GERENCIAMENTO CLAMAV                      "
        echo "===================================================================="
        echo " 1) Instalar ClamAV"
        echo " 2) Atualizar banco de dados de vírus"
        echo "--------------------------------------------------------------------"
        echo " VERIFICAÇÕES:"
        echo " 3) Verificação rápida (home, arquivos até 5MB)"
        echo " 4) Verificação completa do sistema"
        echo " 5) Verificação personalizada (diretório escolhido)"
        echo " 6) Verificação sem remoção (somente detecção)"
        echo "--------------------------------------------------------------------"
        echo " OUTRAS FERRAMENTAS:"
        echo " 7) Exibir último relatório"
        echo " 8) Agendar verificação automática"
        echo " 9) Sair"
        echo "===================================================================="
        read -r -p "Digite a opção desejada: " opcao

        case "$opcao" in
            1)  # Instalar ClamAV
        		echo "Instalando Antivirus ClamAV..." 
        		sudo apt-get update && sudo apt-get install clamav clamav-daemon clamav-freshclam clamtk -y
        
        		echo "Ativando ClamAV para monitoramento em tempo real..."
        		sudo systemctl enable clamav-daemon
        		sudo systemctl start clamav-daemon
        
        		echo "Atualizando o banco de dados de vírus do ClamAV..."
        		sudo systemctl stop clamav-freshclam
        		sudo freshclam
        		sudo systemctl start clamav-freshclam
        
        		echo "Reiniciando o daemon do ClamAV para aplicar atualizações..."
        		sudo systemctl restart clamav-daemon
        
        		echo ""
        		echo "✅ Antivirus ClamAV Instalado e Configurado!"
                pause
                ;;
            
            2)  # Atualizar banco de dados
                atualizar_db
                ;;
            
            3)  # Verificação rápida home
                verificar_diretorio "/home" "--max-filesize=5M --max-scansize=5M" "Verificação rápida (até 5MB)"
                ;;
            
            4)  # Verificação completa
                verificar_diretorio "/" "--recursive --scan-archive=yes" "Verificação completa do sistema"
                ;;
            
            5)  # Verificação personalizada
                echo "Digite o caminho completo do diretório:"
                read -r diretorio
                if [ -d "$diretorio" ]; then
                    verificar_diretorio "$diretorio" "--recursive" "Verificação personalizada"
                else
                    echo "Diretório inválido!"
                    pause
                fi
                ;;
            
            6)  # Verificação somente detecção
                verificar_diretorio "/home" "--recursive -i --no-summary" "Verificação de detecção sem remoção"
                ;;
            
            7)  # Exibir último relatório
                if [ -f "$LOG_FILE" ]; then
                    less "$LOG_FILE"
                else
                    echo "Nenhum relatório encontrado!"
                    pause
                fi
                ;;
            
            8)  # Agendar verificação
                agendar_verificacao
                ;;
            
            9)  # Sair
                echo "Encerrando..."
                exit 0
                ;;
            
            *)
                echo "Opção inválida!"
                pause
                ;;
        esac
    done
}

# Execução inicial
sudo mkdir -p "$LOG_DIR"
sudo chown -R clamav:clamav "$LOG_DIR"
menu
