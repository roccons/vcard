#!/bin/bash

# Verificar si jq está instalado
if ! command -v jq &> /dev/null
then
    echo "jq no está instalado. Por favor, instálalo para continuar." >&2
    exit 1
fi

# 1. Leer y sanitizar datos del JSON
# Se eliminan los caracteres no imprimibles para evitar problemas de codificación.
NOMBRE_COMPLETO=$(jq -r '.nombreCompleto' datos.json | tr -cd '[:print:]')
NOMBRE=$(jq -r '.nombre' datos.json | tr -cd '[:print:]')
TITULO=$(jq -r '.titulo' datos.json | tr -cd '[:print:]')
TELEFONO=$(jq -r '.telefono' datos.json | tr -cd '[:print:]')
EMAIL=$(jq -r '.email' datos.json | tr -cd '[:print:]')
URL=$(jq -r '.url' datos.json | tr -cd '[:print:]')

# 2. Generar el archivo contacto.vcf y escribir las cabeceras
printf "BEGIN:VCARD\r\n" > contacto.vcf
printf "VERSION:3.0\r\n" >> contacto.vcf

# 3. Codificar, formatear y escribir la foto en el vCard
# Usamos un bucle while para un control preciso del formato.
IS_FIRST_LINE=true
base64 foto.jpg | fold -w 75 | while IFS= read -r line; do
  if [ "$IS_FIRST_LINE" = true ]; then
    printf "PHOTO;TYPE=JPEG;ENCODING=BASE64:%s\r\n" "$line" >> contacto.vcf
    IS_FIRST_LINE=false
  else
    printf " %s\r\n" "$line" >> contacto.vcf
  fi
done

# 4. Escribir el resto de los datos del JSON
printf "FN:%s\r\n" "$NOMBRE_COMPLETO" >> contacto.vcf
printf "N:%s\r\n" "$NOMBRE" >> contacto.vcf
printf "TITLE:%s\r\n" "$TITULO" >> contacto.vcf
TELEFONO_CLEAN=$(echo "$TELEFONO" | tr -d '[:space:]')
printf "TEL;TYPE=WORK,VOICE:%s\r\n" "$TELEFONO_CLEAN" >> contacto.vcf
printf "EMAIL:%s\r\n" "$EMAIL" >> contacto.vcf
printf "URL:%s\r\n" "$URL" >> contacto.vcf

# 5. Finalizar el archivo vCard
printf "END:VCARD\r\n" >> contacto.vcf

echo "El archivo contacto.vcf ha sido generado exitosamente."

# --- Generación de index.html desde la plantilla ---

# 6. Leer datos del JSON (reutilizando los ya leídos si es posible)
TELEFONO_RAW=$(echo "$TELEFONO" | tr -d '[:space:]')
TELEFONO_FORMATTED="$TELEFONO"
URL_DISPLAY=$(echo "$URL" | sed 's#https\?://##')

# 7. Usar awk para reemplazar los placeholders en la plantilla y crear index.html
awk \
    -v nc="$NOMBRE_COMPLETO" \
    -v t="$TITULO" \
    -v tr="$TELEFONO_RAW" \
    -v tf="$TELEFONO_FORMATTED" \
    -v e="$EMAIL" \
    -v u="$URL" \
    -v ud="$URL_DISPLAY" \
    '{ 
        gsub("{{NOMBRE_COMPLETO}}", nc); 
        gsub("{{TITULO}}", t); 
        gsub("{{TELEFONO_RAW}}", tr); 
        gsub("{{TELEFONO_FORMATTED}}", tf); 
        gsub("{{EMAIL}}", e); 
        gsub("{{URL}}", u); 
        gsub("{{URL_DISPLAY}}", ud); 
        print 
    }' template.html > index.html

echo "El archivo index.html ha sido generado exitosamente." 
