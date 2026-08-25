# DevOps Hands-on Labs

Bu depo, sistem yöneticiliği ve DevOps süreçleri için oluşturulmuş projeleri içermektedir.

## Proje 1: Vagrant ile Multi-Tier (Çok Katmanlı) Altyapı
**Gereksinimler:** Vagrant, VirtualBox

Bu proje, Vagrant kullanarak Web, App ve DB sunucularını otomatik olarak ayağa kaldırır.

### Nasıl Çalıştırılır?
1. Terminalden proje dizinine gidin.
2. `vagrant up` komutunu çalıştırın.
3. Makineler oluştuktan sonra `vagrant ssh <makine_adi>` (örneğin `vagrant ssh web`) komutuyla giriş yapabilirsiniz.

**Açık Portlar:**
- Web: 80
- DB: 3306

---

## Proje 2: Bash Automation Toolkit
Bu proje; yedekleme, log temizleme ve sistem izleme işlemlerini tek bir çatı altında toplayan modüler bir CLI aracıdır.

### Komutlar (Subcommands)
Aracın tüm özellikleri alt komutlarla (subcommand) çalışır:

- **Sistem İzleme (CPU/RAM/Disk):** `./toolkit.sh monitor`
- **Yedekleme Alma:** `./toolkit.sh backup /home/ubuntu/data ./backups/`
- **Log Temizleme:** `./toolkit.sh clean /var/log/nginx`
- **Haftalık Rapor:** `./toolkit.sh report`
- **Otomasyon (Cron):** `./toolkit.sh cron-setup`
