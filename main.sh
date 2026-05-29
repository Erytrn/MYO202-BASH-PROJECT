#!/bin/bash

# Eray TURAN
# Öğrenci Numarası: 2420191037
# Sertifika 1: https://www.btkakademi.gov.tr/portal/certificate/validate?certificateId=6mqF0P6YKP
# Sertifika 2: https://credsverse.com/credentials/abcac5ea-b99d-4618-999f-c1e93f828b09
# Sertifika 3: https://www.btkakademi.gov.tr/portal/certificate/validate?certificateId=qKrhe9a4xw

LOG_FILE="report.log"
ISO_TARIH=$(date -Iseconds)
echo "Baslangic Zamani: $ISO_TARIH" > $LOG_FILE

echo "" >> $LOG_FILE
echo "DONANIM BILGILERI" >> $LOG_FILE

echo "[ CPU (Islemci Marka ve Model) ]" >> $LOG_FILE
wmic.exe cpu get name, manufacturer >> $LOG_FILE

echo "[ RAM ]" >> $LOG_FILE
wmic.exe memorychip get capacity, manufacturer, serialnumber >> $LOG_FILE

echo "[ ANAKART (Marka, Model ve Anakart UUID) ]" >> $LOG_FILE
wmic.exe baseboard get manufacturer, product, serialnumber >> $LOG_FILE

echo "[ DISK (Model ve Kapasite) ]" >> $LOG_FILE
wmic.exe diskdrive get model, size >> $LOG_FILE

echo "[ MAC Adresi ]" >> $LOG_FILE
getmac.exe >> $LOG_FILE

echo "Donanim bilgileri rapora eklendi"

echo ""
echo "GIRIS"
read -s -p "Proje parolasi girin: " PAROLA
echo ""

GIZLI_PAROLA=$(echo "TVlPKzIwMg==" | base64 --decode)
if [ "$PAROLA" == "$GIZLI_PAROLA" ]; then
echo "PAROLA onaylandi."
echo "Rapor dosyasi AES256 sifreleniyor"
    
gpg --batch --yes --passphrase "$PAROLA" --symmetric --cipher-algo AES256 -o report.log.gpg report.log
    
if [ -f "report.log.gpg" ]; then
echo "Sifreleme yapildi. loglar siliniyor"
rm -f report.log
echo "MYO202-BASH-PROJECT islemler tamamlandi."
else
echo "Sifreleme basarisiz oldu"
exit 1
fi
else
echo "Yanlis parola girdiniz kapatiliyor"
exit 1
fi