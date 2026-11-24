#!/bin/bash

# Uso: ./respaldo.sh carpeta_origen carpeta_destino
ORIGEN="$1"
DESTINO="$2"
FECHA=$(date +%Y-%m-%d)

if [ ! -d "$ORIGEN" ]; then
    echo "Error: la carpeta $ORIGEN no existe"
    exit 1
fi

mkdir -p "$DESTINO"
tar -czf "$DESTINO/respaldo-$FECHA.tar.gz" "$ORIGEN"
echo "Respaldo creado en $DESTINO/respaldo-$FECHA.tar.gz"

