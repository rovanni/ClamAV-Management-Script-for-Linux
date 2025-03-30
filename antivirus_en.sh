#!/bin/bash
###################################################################
# NAME:            clamav_manager.sh
# VERSION:         3.0
# DESCRIPTION:     ClamAV Management Script for Ubuntu Desktop
# DATE:            14/08/2022 (updated 20/05/2024)
# AUTHOR:          Luciano R. Nascimento
# EMAIL:           rovanni@gmail.com
# LICENSE:         GPLv3
# PROJECT:         https://github.com/rovanni/ClamAV-Management-Script-for-Linux/
###################################################################

# Configuration
LOG_DIR="/var/log/clamav"
LOG_FILE="$LOG_DIR/scan_report.log"
AUTO_SCAN_LOG="$LOG_DIR/auto_scan.log"

# Helper functions
function pause() {
    read -r -s -n 1 -p "Press any key to continue..."
    echo
}

function update_db() {
    echo "Updating antivirus database..."
    sudo freshclam -v
    pause
}

function header() {
    sudo mkdir -p "$LOG_DIR"
    sudo chmod 755 "$LOG_DIR"
    sudo touch "$LOG_FILE"
    sudo chmod 644 "$LOG_FILE"
    
    echo "=======================================================" | sudo tee -a "$LOG_FILE"
    echo "                   VIRUS SCAN REPORT                   " | sudo tee -a "$LOG_FILE"
    echo "Start time: $(date +'%d/%m/%Y %H:%M:%S')" | sudo tee -a "$LOG_FILE"
    echo "-------------------------------------------------------" | sudo tee -a "$LOG_FILE"
}

function footer() {
    echo "-------------------------------------------------------" | sudo tee -a "$LOG_FILE"
    echo "End time: $(date +'%d/%m/%Y %H:%M:%S')" | sudo tee -a "$LOG_FILE"
    echo "=======================================================" | sudo tee -a "$LOG_FILE"
    echo "Report saved to: $LOG_FILE"
    echo "View full report now? (Y/n)"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        less "$LOG_FILE"
    fi
    pause
}

function scan_directory() {
    local directory="$1"
    local parameters="$2"
    
    header
    echo "Scan type: $3" | sudo tee -a "$LOG_FILE"
    echo "Target directory: $directory" | sudo tee -a "$LOG_FILE"
    
    sudo clamscan $parameters "$directory" | sudo tee -a "$LOG_FILE"
    footer
}

function schedule_scan() {
    echo "Automatic Scan Scheduling"
    echo "Enter scan time (HH:MM format):"
    read -r time
    echo "Enter directory to scan:"
    read -r directory

    # Validate time input
    if ! [[ "$time" =~ ^[0-9]{2}:[0-9]{2}$ ]]; then
        echo "Invalid time format!"
        pause
        return
    fi

    # Create cron job
    local cron_job="$time * * * * root clamscan --recursive $directory --bell --remove=yes -i --log=$AUTO_SCAN_LOG"
    echo "$cron_job" | sudo tee -a /etc/crontab > /dev/null
    
    echo "Scan scheduled daily at $time for directory: $directory"
    pause
}

# Main menu
function main_menu() {
    while true; do
        clear
        echo "===================================================================="
        echo "                     CLAMAV MANAGEMENT CONSOLE                      "
        echo "===================================================================="
        echo " 1) Install ClamAV"
        echo " 2) Update Virus Database"
        echo "--------------------------------------------------------------------"
        echo " SCAN OPTIONS:"
        echo " 3) Quick Scan (Home directory <5MB files)"
        echo " 4) Full System Scan"
        echo " 5) Custom Directory Scan"
        echo " 6) Detection-Only Scan"
        echo "--------------------------------------------------------------------"
        echo " ADDITIONAL TOOLS:"
        echo " 7) View Last Report"
        echo " 8) Schedule Automatic Scan"
        echo " 9) Exit"
        echo "===================================================================="
        read -r -p "Enter your choice: " choice

        case "$choice" in
            1)  # Install ClamAV
                sudo apt update && sudo apt install clamav clamav-daemon -y
                sudo systemctl enable clamav-freshclam
                pause
                ;;
            
            2)  # Update database
                update_db
                ;;
            
            3)  # Quick home scan
                scan_directory "/home" "--max-filesize=5M --max-scansize=5M" "Quick Scan (<5MB)"
                ;;
            
            4)  # Full system scan
                scan_directory "/" "--recursive --scan-archive=yes" "Full System Scan"
                ;;
            
            5)  # Custom scan
                echo "Enter full directory path:"
                read -r directory
                if [ -d "$directory" ]; then
                    scan_directory "$directory" "--recursive" "Custom Scan"
                else
                    echo "Invalid directory!"
                    pause
                fi
                ;;
            
            6)  # Detection-only scan
                scan_directory "/home" "--recursive -i --no-summary" "Detection-Only Scan"
                ;;
            
            7)  # View last report
                if [ -f "$LOG_FILE" ]; then
                    less "$LOG_FILE"
                else
                    echo "No reports found!"
                    pause
                fi
                ;;
            
            8)  # Schedule scan
                schedule_scan
                ;;
            
            9)  # Exit
                echo "Exiting..."
                exit 0
                ;;
            
            *)
                echo "Invalid option!"
                pause
                ;;
        esac
    done
}

# Initial setup
sudo mkdir -p "$LOG_DIR"
sudo chown -R clamav:clamav "$LOG_DIR"
main_menu
