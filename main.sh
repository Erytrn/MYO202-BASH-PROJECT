#!/bin/bash

# Eray TURAN
# Öğrenci Numarası: 2420191037
# Sertifika 1: https://www.btkakademi.gov.tr/portal/certificate/validate?certificateId=6mqF0P6YKP
# Sertifika 2: https://credsverse.com/credentials/abcac5ea-b99d-4618-999f-c1e93f828b09
# Sertifika 3: https://www.btkakademi.gov.tr/portal/certificate/validate?certificateId=qKrhe9a4xw

LOG_FİLE="report.log"
İSO_TARİH=$(date -Iseconds)
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

ECHO "MAC Adresi" >> $LOG_FILE
getmac >> $LOG_FILE

echo "Donanım bilgileri yüklendi"

