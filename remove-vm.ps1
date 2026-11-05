param([Parameter(Mandatory=$true)][string]$Nombre)
$vbox = "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
if ($Nombre -eq "Windows11 Laboratorio") { Write-Host "No se puede borrar la plantilla." -ForegroundColor Red; exit 1 }
& $vbox unregistervm $Nombre --delete
Write-Host "Puesto $Nombre eliminado" -ForegroundColor Green
