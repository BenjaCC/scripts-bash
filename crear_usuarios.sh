
#!/bin/bash
# Uso: sudo ./crear_usuarios.sh usuarios.txt

ARCHIVO="$1"

if [ -z "$ARCHIVO" ] || [ ! -f "$ARCHIVO" ]; then
    echo "Uso: sudo $0 archivo_de_usuarios"
    exit 1
fi

if [ "$EUID" -ne 0 ]; then
    echo "Ejecuta este script con sudo"
    exit 1
fi

while read -r USUARIO; do
    [ -z "$USUARIO" ] && continue
    if id "$USUARIO" &>/dev/null; then
        echo "El usuario $USUARIO ya existe, se omite"
    else
        useradd -m "$USUARIO"
        echo "Usuario $USUARIO creado"
    fi
done < "$ARCHIVO"

