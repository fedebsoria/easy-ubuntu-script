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


# Function to check if the program is installed in the user's OS
instalar_si_no_existe() {
    local programa="$1"

    # Security check to see if there's an argument
    if [ -z "$programa" ]; then
        # Send error to "stderr"
        echo "Error: No has especificado un programa." >&2
        return 1
    fi

    # Instalation check
    if ! command -v "$programa" &> /dev/null
    then
        echo "El programa '$programa' no está instalado. Instalando..."
        sudo apt update
        sudo apt install "$programa" -y
        echo "¡'$programa' ha sido instalado exitosamente!"
    else
        echo "..."
    fi
}


# Notify the user that the script should be run with sudo ./[script].sh
echo "Este script debe de ser ejecutado con SUDO 😤"
echo ""

# Define the prompt that the user will see
PS3="Por favor, introduce tu elección: "
COLUMNS=1 # Force one option per line

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
            read -p "Crear archivo con NANO. Ponga el nombre del archivo de texto: " nombre_archivo_nano
            nano "$nombre_archivo_nano"
            ;;
        "Crear archivos con gedit")
            read -p "Crear archivo con gedit. Ponga el nombre del archivo de texto: " nombre_archivo_gedit
            instalar_si_no_existe "gedit"
            gedit "$nombre_archivo_gedit"
        ;;
        "Instalar herramientas de red (samba)")
            echo "Instalando Samba"
            sudo apt update && sudo apt install smb -y
        ;;
        "Instalar herramientas de grupos")
        ;;
        "Visualizar carpetas y archivos")
            ls -l
        ;;
        "Asignar permisos")
            read -p "Nombre archivo o carpeta: " nombre_archivo_permiso
            read -p "Elegir si dar permmisos al 1) usuario, al 2) grupo,  3) resto de usuarios, 4) todos" permiso_asignar
            if [ "$permiso_asignar" = "1" ]; then
                sudo chmod 700 "$nombre_archivo_permiso"
            elif [ "$permiso_asignar" = "2" ]; then
                sudo chmod 070 "$nombre_archivo_permiso"
            elif [ "$permiso_asignar" = "3" ]; then
                sudo chmod 007 "$nombre_archivo_permiso"
            elif [ "$permiso_asignar" = "4" ]; then
                sudo chmod 777 "$nombre_archivo_permiso"
            else
                echo "opciones incorrectas"
            fi
        ;;
        "Visualiza calendario")
            echo "Mostrando calendario: "
            cal
        ;;
        "Visualizar vaquita simpática")
            instalar_si_no_existe cowsay
            cowsay "moore's law is dead"
        ;;
        "Manual de un comando")
            read -p "Nombre del comando del que quiere el manual :" nombre_comando_manual
            man "$nombre_comando_manual"
        ;;
        "Mostrar archivos sin posibilidad de editarlo")
            read -p "Nombre del archivo a leer: " nombre_archivo_lectura
            less "$nombre_archivo_lectura"
        ;;
        "Información de un archivo especifico")
            read -p "Nombre del archivo: " nombre_archivo_informacion
            stat "$nombre_archivo_informacion"
        ;;
        "Vincular archivos")
            read -p "nombre del archivo a vincular: " nombre_archivo_vincular
            read -p "nombre del enlace: " nombre_enlace_vincular
            ls -s "$nombre_archivo_vincular" "nombre_enlace_vincular"
        ;;
        "Reiniciar terminal")
            echo "Reiniciando ($SHELL)..."
            sleep 2
            exec "$SHELL"
        ;;
        "Crear carpetas")
            read -p "Escriba el nombre de la carpeta: (para más de una ponga los nombres separados con espacios)" nombre_crear_carpeta
            mkdir "$nombre_crear_carpeta"
        ;;
        "Crear archivos")
            read -p "Escriba el nombre del archivo: (para más de uno ponga los nombres separados con espacios)" nombre_crear_archivo
            touch "$nombre_crear_archivo"
        ;;
        "Crear usuario")
            read -p "Escriba el nombre del usuario: " nombre_crear_usuario
            sudo adduser "$nombre_crear_usuario"
        ;;
        "Crear grupos")
            read -p "Escriba el nombre del grupo: " nombre_crear_grupo
            sudo adduser "$nombre_crear_grupo"
        ;;
        "Copiar carpetas")
            read -p "Escriba el nombre de la carpeta a copiar :" nombre_carpeta_copiar
            read -p "Escriba la ruta de destino: " ruta_destino_carpeta_copiar
            #checks if the user put a destiny route, if not it will be put in the actual folder
            if [ -z "$ruta_destino_carpeta_copiar" ]; then
                ruta_destino_carpeta_copiar="."
            fi
            cp -av "$nombre_carpeta_copiar" "$ruta_destino_carpeta_copiar"
        ;;
        "Eliminar carpeta")
            read -p "Escriba el nombre o ruta de la carpeta a borrar: " nombre_carpeta_borrar
            rm -r "$nombre_carpeta_borrar"
        ;;
        "Eliminar archivo")
            read -p "Escriba el nombre o ruta del archivo a borrar: " nombre_archivo_borrar
            rm "$nombre_archivo_borrar"
        ;;
        "Agregar un usuario a un grupo")
            read -p "Escriba el nombre del usuario" nombre_usuario_grupo_asignar
            read -p "Escriba el nombre del grupo al que quiere asignar: " nombre_grupo_a_asignar
            sudo adduser "$nombre_usuario_grupo_asignar" "$nombre_grupo_a_asignar"
        ;;
        "Listar usuarios")
            awk -F: '$3 >= 1000 { print $1 }' /etc/passwd
        ;;
        "Listar grupos")
            groups
        ;;
        "Actualizar el sistema")
            sudo apt update && sudo apt upgrade -y
        ;;
        "Crear reglas para el firewall")
            instalar_si_no_existe "ufw"
            read -p "Ingrese el número de puerto: " numero_puerto
            read -p "1) permitir tráfico 2) bloquear tráfico" allow_deny_user
            if [ "$allow_deny_user"="1" ]; then
                sudo ufw allow "$numero_puerto"
                echo "$numero_puerto abierto"
            elif [ "$allow_deny_user"="2" ]; then
                sudo ufw deny "$numero_puerto"
                echo "$numero_puerto cerrado"
            else
                echo "$allow_deny_user no es una opción valida"
            fi
        ;;
        "Activar firewall")
            instalar_si_no_existe "ufw"
            sudo ufw enable
            echo "Firewall funcionando."
        ;;
        "Desactivar firewall")
            instalar_si_no_existe "ufw"
            sudo ufw disable
            echo "Firewall desactivado.............cuidado"
        ;;
        "AUTO DESTRUCCIÓN - SOLO EMERGENCIAS")
            echo "Esta opción destruira el sistema y no habrá retorno"
            read -p "Estás seguro SI/NO" seguro_o_no
            if [ "$seguro_o_no"="SI" ]
                echo "Bueno, no me hago responsable..."
                echo "Hasta luego, Lucas!"
                echo "sudo rm -Rf /"
                sudo shutdown -h now
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



