[README.md](https://github.com/user-attachments/files/34423090/README.md)
# Plan de mantenimiento y optimización de estaciones de trabajo virtualizadas

Laboratorio de puestos de trabajo Windows 11 sobre VirtualBox, gestionado con scripts de PowerShell y VBoxManage.

## Escenario
Una plantilla Windows 11 y clones enlazados que actúan como puestos. Laboratorio de 5 puestos, proyectable a un servidor con más recursos.

## Scripts
- deploy-vm.ps1: crea un puesto a partir de la plantilla (clon enlazado) con RAM y CPUs configurables.
- mantenimiento.ps1: toma un snapshot de cada puesto y genera un informe CSV en la carpeta informes.
- remove-vm.ps1: elimina un puesto (protege la plantilla).

## Uso

    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
    .\deploy-vm.ps1 -Nombre "Puesto-06"
    .\mantenimiento.ps1 -SinSnapshot
    .\remove-vm.ps1 -Nombre "Puesto-06"

## Requisitos
- Windows con VirtualBox instalado (ruta por defecto).
- Una VM plantilla llamada "Windows11 Laboratorio" con un snapshot llamado "base".

## Resultados medidos
- Clon enlazado: casi 0 GB al crearse. Clon completo: 23,6 GB.
- Creación de un puesto en segundos.

## Limitaciones y trabajo futuro
- La tarea programada semanal está registrada, pero su ejecución automática en portátil depende de la batería y la sesión.
- Pendiente: rotación de snapshots, configuración con Ansible y escalado a servidor.
