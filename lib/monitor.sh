#!/bin/bash
# CPU, RAM, Disk kontrolü ve eşik aşımında terminal uyarısı

check_system() {
    # CPU (Yük ortalaması 1 dakika)
    local cpu_load=$(uptime | awk -F'load average:' '{print $2}' | cut -d, -f1 | xargs)
    local cpu_threshold=2.0
    if (( $(echo "$cpu_load > $cpu_threshold" | bc -l) )); then
        echo "[UYARI] CPU Yükü Çok Yüksek!: $cpu_load (Eşik: $cpu_threshold)"
    fi

    # RAM (Kullanım yüzdesi)
    local ram_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    local ram_threshold=80.0
    if (( $(echo "$ram_usage > $ram_threshold" | bc -l) )); then
        echo "[UYARI] RAM Kullanımı Çok Yüksek!: %$ram_usage (Eşik: %$ram_threshold)"
    fi

    # Disk (Kök dizin)
    local disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    local disk_threshold=85
    if [ $disk_usage -gt $disk_threshold ]; then
        echo "[UYARI] Disk Alanı Doluyor!: %$disk_usage (Eşik: %$disk_threshold)"
    fi
}
