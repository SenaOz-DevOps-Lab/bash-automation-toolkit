#!/bin/bash
# toolkit.sh - Ana CLI aracı

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$SCRIPT_DIR/lib"

# Tüm alt modülleri yükle
source "$LIB_DIR/backup.sh"
source "$LIB_DIR/log-cleaner.sh"
source "$LIB_DIR/monitor.sh"

# Yardım menüsü
show_help() {
    echo "Kullanım: $0 {backup|clean|monitor|report} [parametreler]"
    echo ""
    echo "  backup <kaynak> <hedef>       : Belirtilen dizini yedekler."
    echo "  clean <log_dizini> <gün>      : Belirtilen günden eski logları siler."
    echo "  monitor                       : Sistem durumunu kontrol eder (CPU/RAM/Disk)."
    echo "  report                        : Haftalık özet rapor üretir."
    echo "  cron-setup                    : Tüm görevleri cron'a ekler."
}

# Haftalık rapor oluşturucu
generate_report() {
    echo "=== HAFTALIK SİSTEM RAPORU ($(date)) ===" > /tmp/system_report.txt
    echo "----------------------------------------" >> /tmp/system_report.txt
    echo "CPU Yükü: $(uptime)" >> /tmp/system_report.txt
    echo "RAM Kullanımı: $(free -h)" >> /tmp/system_report.txt
    echo "Disk Kullanımı: $(df -h /)" >> /tmp/system_report.txt
    echo "Son Yedekler: $(ls -lh $SCRIPT_DIR/backups/ | tail -5)" >> /tmp/system_report.txt
    echo "----------------------------------------" >> /tmp/system_report.txt
    cat /tmp/system_report.txt
}

# Ana Case Yapısı
case "$1" in
    backup)
        if [ -z "$2" ] || [ -z "$3" ]; then
            echo "Hata: backup <kaynak> <hedef>"
            exit 1
        fi
        backup "$2" "$3"
        ;;
    clean)
        if [ -z "$2" ]; then
            echo "Hata: clean <log_dizini>"
            exit 1
        fi
        clean_logs "$2" "*.log" 30  # Varsayılan 30 gün
        ;;
    monitor)
        check_system
        ;;
    report)
        generate_report
        ;;
    cron-setup)
        # Cron'a ekle (Bu scriptin path'ini mutlak verin!)
        (crontab -l 2>/dev/null; echo "0 9 * * 1 $SCRIPT_DIR/toolkit.sh report >> $SCRIPT_DIR/logs/weekly_report.log") | crontab -
        (crontab -l 2>/dev/null; echo "0 2 * * * $SCRIPT_DIR/toolkit.sh backup /home/ubuntu/data $SCRIPT_DIR/backups/") | crontab -
        (crontab -l 2>/dev/null; echo "0 3 * * * $SCRIPT_DIR/toolkit.sh clean /var/log/nginx") | crontab -
        echo "Cron görevleri eklendi. Kontrol etmek için: crontab -l"
        ;;
    *)
        show_help
        ;;
esac
