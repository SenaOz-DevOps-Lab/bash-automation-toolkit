#!/bin/bash
# Kullanım: clean_logs /var/log/nginx "*.log" 30 (30 günden eski logları sil)
clean_logs() {
    local log_dir=$1
    local pattern=$2
    local days=$3
    
    echo "[LOG-CLEANER] $log_dir içinde $days günden eski $pattern dosyaları siliniyor..."
    find "$log_dir" -name "$pattern" -type f -mtime +"$days" -delete
    echo "[OK] Temizlik tamamlandı."
}
