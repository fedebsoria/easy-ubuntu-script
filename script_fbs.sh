#!/usr/bin/env bash

# Simple CLI flags so the script can run in CI/non-interactive environments.
# Supported flags: --non-interactive, --ci, --version, --help
for arg in "$@"; do
    case "$arg" in
        --non-interactive|--ci)
            echo "CI mode: non-interactive run"
            echo "script: $(basename "$0")"
            echo "bash: $(bash --version | head -n1)"
            if [ -f /etc/os-release ]; then
                . /etc/os-release
                echo "os: ${NAME:-Unknown} ${VERSION:-}" 
            fi
            exit 0
            ;;
        --version)
            echo "$(basename "$0") version 1.0"
            exit 0
            ;;
        --help|-h)
            echo "Usage: $0 [--non-interactive|--ci] [--version] [--help]"
            echo "When run with --non-interactive or --ci the script will print basic info and exit 0 (suitable for CI tests)."
            exit 0
            ;;
    esac
done

# CRIPT
# LINUX
# Crear un menú con 30 opciones:
# 1. Muestra la versión de Linux
# 2. Crear archivos con nano
# 3. Crear archivos con gedit
# 4. Instalar herramientas de red (samba)
# 5. Instalar herramientas de grupos
# 6. Visualizar carpetas y archivos
# 7. Asignar permisos
# 8. Visualiza calendario
# 9. Visualizar vaquita
# simpática 10.Manual de un
# comando
# 11.Mostrar archivos sin posibilidad de editarlo
# 12.Información de un archivo especifico
# 13.Vincular archivos
# 14.Reiniciar terminal
# 15.Crear carpetas
# 16.Crear archivos
# 17.Crear usuarios
# 18.Crear grupos
# 19.Copiar carpetas
# 20.Eliminar carpeta
# 21.Eliminar archivo
# 22.Agregar un usuario a un grupo
# 23.Listar usuarios
# 24.Listar grupos
# 25.Actualizar el sistema
# 26.Salir
# NOTA
# Continuar hasta 30 con opciones inventadas por vosotros


#Aviso al usuario de que debe de correr el script con sudo ./[script].sh
echo "Este script debe de ser ejecutado con SUDO 😤"
echo ""

# Definir el prompt que verá el usuario
PS3="Por favor, introduce tu elección: "
COLUMNS=1 # Fuerza una opción por línea

opciones=("Muestra la versión de Linux"
"Crear archivos con nano"
"Crear archivos con gedit"
"Instalar herramientas de red (samba)"
"Instalar herramientas de grupos"
"Visualizar carpetas y archivos"
"Asignar permisos"
"Visualiza calendario"
"Visualizar vaquita simpática"
"Manual de un "
"Mostrar archivos sin posibilidad de editarlo"
"Información de un archivo especifico"
"Vincular archivos"
"Reiniciar terminal"
"Crear carpetas"
"Crear archivos"
"Crear usuarios"
"Crear grupos"
"Copiar carpetas"
"Eliminar carpeta"
"Eliminar archivo"
"Agregar un usuario a un grupo"
"Listar usuarios"
"Listar grupos"
"Actualizar el sistema"
"Crear reglas para el firewall"
"Activar firewall"
"Desactivar firewall"
"AUTO DESTRUCCIÓN - SOLO EMERGENCIAS"
"Salir"
)

echo "---- Menu de admyn fácil ----"

#Inicia el bucle del menú

select opt in "${opciones[@]}"
do
    case $opt in
        "Muestra la versión de Linux")
            echo "Mostrando la versión de Linux"
            cat /etc/os-release
            ;;
        "Crear archivos con nano")
            read -p "Creador de achivos. Ponga el nombre del archivo de texto: " nombre_archivo
            nano $nombre_archivo
            ;;
        "Crear archivos con gedit")
        ;;
        "Instalar herramientas de red (samba)")
        ;;
        "Instalar herramientas de grupos")
        ;;
        "Visualizar carpetas y archivos")
        ;;
        "Asignar permisos")
        ;;
        "Visualiza calendario")
        ;;
        "Visualizar vaquita simpática")
        ;;
        "Manual de un ")
        ;;
        "Mostrar archivos sin posibilidad de editarlo")
        ;;
        "Información de un archivo especifico")
        ;;
        "Vincular archivos")
        ;;
        "Reiniciar terminal")
        ;;
        "Crear carpetas")
        ;;
        "Crear archivos")
        ;;
        "Crear usuarios")
        ;;
        "Crear grupos")
        ;;
        "Copiar carpetas")
        ;;
        "Eliminar carpeta")
        ;;
        "Eliminar archivo")
        ;;
        "Agregar un usuario a un grupo")
        ;;
        "Listar usuarios")
        ;;
        "Listar grupos")
        ;;
        "Actualizar el sistema")
        ;;
        "Crear reglas para el firewall")
        ;;
        "Activar firewall")
        ;;
        "Desactivar firewall")
        ;;
        "AUTO DESTRUCCIÓN - SOLO EMERGENCIAS")
        ;;
        "Salir")
            echo "Adios!"
            break;
        ;;
        *)
            echo "Opción invalida. Elige algo de la lista, que solo soy un script, no chatGPT ='( "
        ;;
    esac
done



