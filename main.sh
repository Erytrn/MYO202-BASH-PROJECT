#!/bin/bash

# Eray TURAN
# Öğrenci Numarası: 2420191037
# Sertifika 1: https://www.btkakademi.gov.tr/portal/certificate/validate?certificateId=6mqF0P6YKP
# Sertifika 2: https://credsverse.com/credentials/abcac5ea-b99d-4618-999f-c1e93f828b09
# Sertifika 3: https://www.btkakademi.gov.tr/portal/certificate/validate?certificateId=qKrhe9a4xw

LOG_FILE="report.log"
ISO_TARIH=$(date -Iseconds)
echo "Başlangıç Zamanı: $ISO_TARIH" > $LOG_FILE

echo "" >> $LOG_FILE
echo "Donanım bilgisi" >> $LOG_FILE

echo "CPU" >> $LOG_FILE
wmic cpu get name >> $LOG_FILE

echo "RAM" >> $LOG_FILE
wmic memorychip get capacity >> $LOG_FILE

echo "ANAKART" >> $LOG_FILE
wmic baseboard get product,Manufacturer >> $LOG_FILE

echo "Disk Sistem UUID" >> $LOG_FILE
wmic csproduct get uuid >> $LOG_FILE

echo "MAC Adresi" >> $LOG_FILE
getmac >> $LOG_FILE

echo "Donanım bilgileri yüklendi"

echo ""
echo "Guvenlı Gırıs"
read -s -p "Proje parolası girin (MYO+202): " Parola
echo ""
if ["$PAROLA" == "MYO+202"]; then
echo "Parola onaylandi"
else
echo "Hata:Yanlış parola girdiniz kapatılıyor"
exit 1
fi

echo "Rapor dosyası AES256 ile şifreleniyor"
gpg --batch --yes --passphrase "$PAROLA" --symmetric --cipher-algo AES256 -o report.log.gpg report.log
if [-f "report.log.gpg" ]; then
echo "Şifreleme yapıldı Orjinal güvensiz loglar siliniyo"
rm -f report.log
echo "MYO202-BASH-PROJECT işlemler tamamlandı"
else
echo "Şifreleme işlemi başarısız oldu"
exit 1
fi
