# Easy Ubuntu Script

## 📜 Descripción (Español)

`script_fbs.sh` es un script de BASH diseñado para simplificar tareas administrativas comunes en sistemas Ubuntu y derivados de Debian. El script presenta un menú interactivo que permite a los usuarios realizar acciones complejas con una sola pulsación de tecla.

El objetivo es proporcionar una herramienta "todo en uno" para usuarios que prefieren un menú guiado en lugar de memorizar múltiples comandos.

### Características Principales

* **Gestión de usuarios y grupos:** Crear usuarios, grupos y añadir usuarios a grupos.
* **Gestión de paquetes:** Instala programas automáticamente (como `samba`, `gedit`, `cowsay`, `ufw`) solo si es necesario, gracias a una función de comprobación.
* **Archivos y carpetas:** Crear, eliminar, copiar, listar, vincular, ver información y mostrar contenido de forma segura.
* **Permisos:** Asignar permisos comunes (propietario, grupo, todos).
* **Firewall:** Activar, desactivar y crear reglas simples con UFW.
* **Sistema:** Actualizar el sistema, ver el calendario, reiniciar la terminal y más.

### Uso

1.  Clona el repositorio:
    ```bash
    git clone [https://github.com/fedebsoria/easy-ubuntu-script.git](https://github.com/fedebsoria/easy-ubuntu-script.git)
    cd easy-ubuntu-script
    ```
2.  Da permisos de ejecución al script:
    ```bash
    chmod +x script_fbs.sh
    ```
3.  Ejecuta el script con `sudo` (necesario para la mayoría de las tareas):
    ```bash
    sudo ./script_fbs.sh
    ```

---

## 📜 Description (English)

`script_fbs.sh` is a BASH script designed to simplify common administrative tasks on Ubuntu and Debian-based systems. The script provides an interactive menu that allows users to perform complex actions with a single keystroke.

The goal is to provide an "all-in-one" tool for users who prefer a guided menu over memorizing multiple commands.

### Key Features

* **User & Group Management:** Create users, groups, and add users to groups.
* **Package Management:** Automatically installs programs (like `samba`, `gedit`, `cowsay`, `ufw`) only if they are missing, thanks to a built-in check function.
* **Files & Directories:** Create, delete, copy, list, link, view info, and safely display file contents.
* **Permissions:** Assign common permissions (owner, group, all).
* **Firewall:** Enable, disable, and create simple rules with UFW.
* **System:** Update the system, view the calendar, restart the shell, and more.

### Usage

1.  Clone the repository:
    ```bash
    git clone [https://github.com/fedebsoria/easy-ubuntu-script.git](https://github.com/fedebsoria/easy-ubuntu-script.git)
    cd easy-ubuntu-script
    ```
2.  Make the script executable:
    ```bash
    chmod +x script_fbs.sh
    ```
3.  Run the script with `sudo` (required for most tasks):
    ```bash
    sudo ./script_fbs.sh
    ```

---

## 🤖 Automated Testing

This repository includes a `tests/` folder for automated integrity checks.

* `test.sh`: A BASH script used to test the script's non-interactive mode (e.g., `script_fbs.sh --ci`) within a Linux environment.
* `test.ps1`: A PowerShell script designed to run tests from a Windows/PowerShell environment. This allows for testing the script's CI flags from a Windows machine without needing to open a local WSL instance.

Furthermore, this repository is configured with **GitHub Actions** to automatically run this test suite on every push and pull request, ensuring the script's core functionality remains stable and reliable.

## 🇪🇸 Explicación de las Flags (Argumentos)

### `--non-interactive | --ci`

* **Propósito:** Permite que el script se ejecute en un entorno automatizado, como **CI/CD** (Integración Continua) o un test.
* **Acción:**
    1.  Imprime información básica del sistema (nombre del script, versión de BASH, sistema operativo).
    2.  `exit 0`: Esta es la parte más importante. Termina el script **inmediatamente** con un código de "éxito" (0).
* **Resultado:** Esto previene que el script continúe y muestre el menú interactivo, el cual "colgaría" un sistema de testing automatizado al esperar una entrada del usuario.

### `--version`

* **Propósito:** Una bandera estándar para mostrar la versión del script.
* **Acción:**
    1.  Imprime el nombre del script y su número de versión.
    2.  Termina el script inmediatamente.

### `--help | -h`

* **Propósito:** Una bandera estándar para mostrar ayuda al usuario. (`-h` es el atajo corto).
* **Acción:**
    1.  Imprime un mensaje de "Uso" que explica los comandos disponibles (ej. `Usage: $0 [--version] [--help]`).
    2.  `exit 0`: Termina el script inmediatamente.

---

## 🇬🇧 Flag Explanation

### `--non-interactive | --ci`

* **Purpose:** Allows the script to be run in an automated environment, such as a **CI/CD** (Continuous Integration) pipeline or a test.
* **Action:**
    1.  It prints basic system information (script name, BASH version, OS).
    2.  `exit 0`: This is the most important part. It **immediately** exits the script with a "success" code (0).
* **Result:** This prevents the script from continuing on to display the interactive menu, which would "hang" an automated testing system while it waits for human input.

### `--version`

* **Purpose:** A standard flag to display the script's version.
* **Action:**
    1.  Prints the script's name and its version number (e.g., `script_fbs.sh version 1.0`).
    2.  `exit 0`: Immediately exits the script.

### `--help | -h`

* **Purpose:** A standard flag to show help information to the user. (`-h` is the short alias).
* **Action:**
    1.  Prints a "Usage" message explaining the available commands (e.g., `Usage: $0 [--version] [--help]`).
    2.  `exit 0`: Immediately exits the script.
