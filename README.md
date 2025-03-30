# ClamAV Management Script for Linux

![GitHub license](https://img.shields.io/badge/license-GPLv3-blue.svg)

## 🚀 Getting Started

Advanced menu-driven script for virus scanning and system protection using ClamAV.

### 📋 Prerequisites
- Ubuntu/Debian-based distribution
- sudo privileges
- Internet connection (for installation/updates)

## 🌟 Key Features

### Core Functions
- **Install ClamAV** with proper configuration
- **Automatic database updates**
- **Scheduled scans** with cron integration
- **Comprehensive logging** system

### Scanning Options
- 🚀 Quick Scan (Home folder <5MB files)
- 🔍 Full System Scan
- 📂 Custom Directory Scan
- 👁️ Detection-Only Mode
- ⚡ Multi-threaded scanning

### Advanced Features
- 📄 Automatic report generation
- 🛡️ Safe removal of threats
- ⏰ Scheduled scans
- 📈 Log management and viewing

## 📄 License
GNU General Public License v3.0 - See [LICENSE](https://github.com/rovanni/clamav-management-script/blob/main/LICENSE)

---

# Script de Gerenciamento ClamAV para Linux

## 🚀 Começando

Script avançado com menu para verificação de vírus e proteção do sistema usando ClamAV.

### 📋 Pré-requisitos
- Distribuição baseada em Ubuntu/Debian
- Privilégios sudo
- Conexão com internet (para instalação/atualizações)

## 🌟 Funcionalidades Principais

### Funções Principais
- **Instalação do ClamAV** com configuração adequada
- **Atualizações automáticas** de banco de dados
- **Verificações agendadas** com integração cron
- Sistema abrangente de **registro de logs**

### Opções de Verificação
- 🚀 Verificação Rápida (Home até 5MB)
- 🔍 Verificação Completa do Sistema
- 📂 Verificação em Diretório Personalizado
- 👁️ Modo Somente Detecção
- ⚡ Verificação Multithread

### Recursos Avançados
- 📄 Geração automática de relatórios
- 🛡️ Remoção segura de ameaças
- ⏰ Verificações programadas
- 📈 Gerenciamento e visualização de logs

## 📄 Licença
GNU General Public License v3.0 - Veja [LICENSE](https://github.com/rovanni/clamav-management-script/blob/main/LICENSE)

---

## 🛠️ Technical Details

### Scanning Parameters
| Option          | Command Parameters                          |
|-----------------|---------------------------------------------|
| Quick Scan      | `--max-filesize=5M --max-scansize=5M`       |
| Full System     | `--recursive --scan-archive=yes`            |
| Custom Scan     | `--recursive --bell --remove=yes`           |
| Detection-Only  | `--recursive -i --no-summary`               |

### System Integration
- Automatic log rotation
- Systemd service management
- Cron job scheduling
- Permission management

---

## ✒️ Author / Autor
**Luciano R. Nascimento**  
[![Email](https://img.shields.io/badge/Email-rovanni%40gmail.com-blue?logo=gmail)](mailto:rovanni@gmail.com)  
[![GitHub](https://img.shields.io/badge/GitHub-rovanni-blue?logo=github)](https://github.com/rovanni)
