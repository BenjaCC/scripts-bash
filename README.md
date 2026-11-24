El script comprime una carpeta en un archivo y lo guarda en otra carpeta con la fecha de hoy. Es un respaldo (backup).

bash
#!/bin/bash

Le dice al sistema que este archivo se ejecuta con Bash. Siempre va en la primera línea.

bash
ORIGEN="$1"
DESTINO="$2"

Guarda en variables lo que escribas al ejecutarlo. $1 es el primer dato (la carpeta que quieres respaldar) y $2 es el segundo (dónde guardar el respaldo). Por ejemplo, en ./respaldo.sh ~/prueba ~/respaldos, ORIGEN es ~/prueba y DESTINO es ~/respaldos.

bash
FECHA=$(date +%Y-%m-%d)

Guarda la fecha de hoy en una variable, con formato como 2026-11-23. Sirve para que el nombre del respaldo diga cuándo se hizo.

bash
if [ ! -d "$ORIGEN" ]; then
    echo "Error: la carpeta $ORIGEN no existe"
    exit 1
fi

Es una comprobación. Si la carpeta de origen no existe (! -d significa "no es un directorio"), muestra un error y se detiene. Es lo mismo que viste en el curso con if [ ! -d $FOO ].

bash
mkdir -p "$DESTINO"

Crea la carpeta de destino si no existe. El -p evita error si ya estaba creada.

bash
tar -czf "$DESTINO/respaldo-$FECHA.tar.gz" "$ORIGEN"

Es la parte principal. Usa tar para empaquetar y comprimir la carpeta de origen en un archivo .tar.gz dentro del destino. Las letras c, z y f significan crear, comprimir con gzip y nombrar el archivo. Es el mismo comando que aprendiste en la parte de compresión.

bash
echo "Respaldo creado en ..."

Muestra un mensaje de que terminó bien.

Ejemplo de cómo funciona
Si ejecutas:

bash
./respaldo.sh ~/prueba ~/respaldos

Se crea el archivo ~/respaldos/respaldo-2026-11-23.tar.gz, que contiene todo lo que había en ~/prueba.

Para verlo con tus ojos, después de ejecutarlo haz:

bash
ls ~/respaldos
tar -tzf ~/respaldos/respaldo-*.tar.gz

El primer comando muestra el archivo creado y el segundo lista lo que hay dentro, igual que en el curso## respaldo.sh

Script que crea un respaldo comprimido de una carpeta.

### Qué hace
Toma una carpeta de origen, la comprime en un archivo `.tar.gz` y lo guarda en una carpeta de destino. El nombre del archivo incluye la fecha del día, así que cada respaldo queda identificado.

### Uso
```bash
./respaldo.sh <carpeta_origen> <carpeta_destino>
```

### Ejemplo
```bash
./respaldo.sh ~/documentos ~/respaldos
```
Resultado: `~/respaldos/respaldo-2026-11-23.tar.gz`

### Cómo funciona
1. Recibe dos argumentos: la carpeta a respaldar (`$1`) y dónde guardarla (`$2`).
2. Obtiene la fecha actual con `date` para nombrar el archivo.
3. Verifica con un `if` que la carpeta de origen exista. Si no existe, muestra un error y termina.
4. Crea la carpeta de destino si no existía (`mkdir -p`).
5. Comprime la carpeta con `tar -czf`.
6. Muestra un mensaje con la ruta del respaldo creado.

### Conceptos que practico
- Argumentos de script (`$1`, `$2`)
- Variables y sustitución de comandos (`$(date ...)`)
- Condicionales (`if [ ! -d ... ]`)
- Códigos de salida (`exit 1`)
- Compresión y empaquetado con `tar`


## crear_usuarios.sh

Crea usuarios del sistema a partir de un archivo de texto con un nombre por línea.

### Uso
```bash
sudo ./crear_usuarios.sh usuarios.txt
```

### Cómo funciona
1. Valida que se pase un archivo existente y que se ejecute con `sudo`.
2. Lee el archivo línea por línea con un bucle `while read`.
3. Si el usuario ya existe (`id`), lo omite y avisa.
4. Si no existe, lo crea con `useradd -m` (con su directorio home).

### Conceptos que practico
- Bucles `while` y lectura de archivos
- Validación de argumentos y de permisos (`$EUID`)
- Gestión de usuarios (`useradd`, `id`)
- Idempotencia: ejecutar el script dos veces no rompe nada

