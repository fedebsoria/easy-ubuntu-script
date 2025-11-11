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
COLUMNS=3 # Force two option per line

opciones=("Muestra la versión de Linux"
"Crear archivos con nano"
"Crear archivos con gedit"
"Instalar herramientas de red (samba)"
"Instalar herramientas de grupos"
"Visualizar carpetas y archivos"
"Asignar permisos"
"Visualiza calendario"
"Visualizar vaquita simpática"
"Manual de un comando"
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
while true;do
#Starts menu loop
    echo "-----------------------------"
    select opt in "${opciones[@]}"
    do
        case $opt in
            "Muestra la versión de Linux")
                echo "Mostrando la versión de Linux"
                cat /etc/os-release
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
                ;;
            "Crear archivos con nano")
                read -p "Crear archivo con NANO. Ponga el nombre del archivo de texto: " nombre_archivo_nano
                nano "$nombre_archivo_nano"
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
                ;;
            "Crear archivos con gedit")
                read -p "Crear archivo con gedit. Ponga el nombre del archivo de texto: " nombre_archivo_gedit
                instalar_si_no_existe "gedit"
                gedit "$nombre_archivo_gedit"
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
            ;;
            "Instalar herramientas de red (samba)")
                echo "Instalando Samba"
                sudo apt update && sudo apt install samba -y
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
            ;;
            "Instalar herramientas de grupos")
                echo "En construcción"
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
            ;;
            "Visualizar carpetas y archivos")
                ls -l
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
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
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
            ;;
            "Visualiza calendario")
                instalar_si_no_existe ncal
                echo "Mostrando calendario: "
                ncal
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
            ;;
            "Visualizar vaquita simpática")
                instalar_si_no_existe cowsay
                cowsay "moore's law is dead"
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
            ;;
            "Manual de un comando")
                read -p "Nombre del comando del que quiere el manual :" nombre_comando_manual
                man "$nombre_comando_manual"
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
            ;;
            "Mostrar archivos sin posibilidad de editarlo")
                read -p "Nombre del archivo a leer: " nombre_archivo_lectura
                less "$nombre_archivo_lectura"
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
            ;;
            "Información de un archivo especifico")
                read -p "Nombre del archivo: " nombre_archivo_informacion
                stat "$nombre_archivo_informacion"
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
            ;;
            "Vincular archivos")
                read -p "nombre del archivo a vincular: " nombre_archivo_vincular
                read -p "nombre del enlace: " nombre_enlace_vincular
                ls -s "$nombre_archivo_vincular" "$nombre_enlace_vincular"
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
            ;;
            "Reiniciar terminal")
                echo "Reiniciando ($SHELL)..."
                sleep 2
                exec "$SHELL"
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
            ;;
            "Crear carpetas")
                read -p "Escriba el nombre de la carpeta: (para más de una ponga los nombres separados con espacios)" nombre_crear_carpeta
                mkdir "$nombre_crear_carpeta"
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
            ;;
            "Crear archivos")
                read -p "Escriba el nombre del archivo: (para más de uno ponga los nombres separados con espacios)" nombre_crear_archivo
                touch "$nombre_crear_archivo"
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
            ;;
            "Crear usuario")
                read -p "Escriba el nombre del usuario: " nombre_crear_usuario
                sudo adduser "$nombre_crear_usuario"
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
            ;;
            "Crear grupos")
                read -p "Escriba el nombre del grupo: " nombre_crear_grupo
                sudo addgroup "$nombre_crear_grupo"
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
            ;;
            "Copiar carpetas")
                read -p "Escriba el nombre de la carpeta a copiar :" nombre_carpeta_copiar
                read -p "Escriba la ruta de destino: " ruta_destino_carpeta_copiar
                #checks if the user put a destiny route, if not it will be put in the actual folder
                if [ -z "$ruta_destino_carpeta_copiar" ]; then
                    ruta_destino_carpeta_copiar="."
                fi
                cp -av "$nombre_carpeta_copiar" "$ruta_destino_carpeta_copiar"
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
            ;;
            "Eliminar carpeta")
                read -p "Escriba el nombre o ruta de la carpeta a borrar: " nombre_carpeta_borrar
                rm -r "$nombre_carpeta_borrar"
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
                ;;
            "Eliminar archivo")
                read -p "Escriba el nombre o ruta del archivo a borrar: " nombre_archivo_borrar
                rm "$nombre_archivo_borrar"
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
                ;;
            "Agregar un usuario a un grupo")
                read -p "Escriba el nombre del usuario" nombre_usuario_grupo_asignar
                read -p "Escriba el nombre del grupo al que quiere asignar: " nombre_grupo_a_asignar
                sudo adduser "$nombre_usuario_grupo_asignar" "$nombre_grupo_a_asignar"
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
            ;;
            "Listar usuarios")
                awk -F: '$3 >= 1000 { print $1 }' /etc/passwd
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
            ;;
            "Listar grupos")
                groups
                read -p "Presione cualquier tecla para volver al menú"
                echo "-----------------"
                break
            ;;
            "Actualizar el sistema")
                sudo apt update && sudo apt upgrade -y
                read -p "Presione cualquier tecla para volver al menú"
                echo "-----------------"
                break
            ;;
            "Crear reglas para el firewall")
                instalar_si_no_existe "ufw"
                read -p "Ingrese el número de puerto: " numero_puerto
                read -p "1) permitir tráfico 2) bloquear tráfico" allow_deny_user
                case "$allow_deny_user" in
                    1)
                        sudo ufw allow "$numero_puerto"
                        echo "$numero_puerto abierto"
                        ;;
                    2)
                        sudo ufw deny "$numero_puerto"
                        echo "$numero_puerto cerrado"
                        ;;
                    *)
                        echo "$allow_deny_user no es una opción valida"
                        ;;
                esac
                read -p "Presione cualquier tecla para volver al menú"
                echo "-----------------"
                break
            ;;
            "Activar firewall")
                instalar_si_no_existe "ufw"
                sudo ufw enable
                echo "Firewall funcionando."
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
            ;;
            "Desactivar firewall")
                instalar_si_no_existe "ufw"
                sudo ufw disable
                echo "Firewall desactivado.............cuidado"
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
            ;;
            "AUTO DESTRUCCIÓN - SOLO EMERGENCIAS")
                echo "Esta opción destruira el sistema y no habrá retorno"
                read -p "Estás seguro SI/NO" seguro_o_no
                if [ "$seguro_o_no" = "SI" ]; then
                    echo "Bueno, no me hago responsable..."
                    echo "Hasta luego, Lucas!"
                    echo "sudo rm -Rf /"
                    sudo shutdown -h now
                else
                    echo "Operación cancelada."
                fi
                echo "-----------------"
                read -p "Presione cualquier tecla para volver al menú"
                break
            ;;
            "Salir")
                echo "Adios!"
                exit 0;
            ;;
            *)
                echo "Opción invalida. Elige algo de la lista, que solo soy un script, no chatGPT ='( "
                echo "-----------------"
                break
            ;;
        esac
    done
done


