#!/bin/bash
# Kullanım: source lib/backup.sh && backup /path/to/source /path/to/dest
backup() {
    local source_dir=$1
    local dest_dir=$2
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_name="backup_$(basename "$source_dir")_$timestamp.tar.gz"
    
    echo "[BACKUP] Kaynak: $source_dir, Hedef: $dest_dir/$backup_name"
    tar -czf "$dest_dir/$backup_name" -C "$(dirname "$source_dir")" "$(basename "$source_dir")" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo "[OK] Yedek başarıyla alındı: $dest_dir/$backup_name"
        # 7 günden eski yedekleri sil (Log rotation mantığı)
        find "$dest_dir" -name "*.tar.gz" -mtime +7 -delete
    else
        echo "[ERROR] Yedekleme başarısız!"
        return 1
    fi
}
