param(
    [string]$Plantilla = "Windows11 Laboratorio",
    [switch]$SinSnapshot
)

$vbox  = "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
$fecha = Get-Date -Format "yyyy-MM-dd_HH-mm"
$carpeta = "C:\Proyecto\informes"
New-Item -ItemType Directory -Path $carpeta -Force | Out-Null

# Lista de puestos (todas las VMs menos la plantilla)
$vms = & $vbox list vms | ForEach-Object { ($_ -split '"')[1] } | Where-Object { $_ -ne $Plantilla }

$informe = foreach ($vm in $vms) {
    $info   = & $vbox showvminfo $vm --machinereadable
    $estado = (($info | Select-String '^VMState=').ToString().Split('=')[1]).Trim('"')
    $ram    = ($info | Select-String '^memory=').ToString().Split('=')[1]
    $cpu    = ($info | Select-String '^cpus=').ToString().Split('=')[1]

    if (-not $SinSnapshot) {
        & $vbox snapshot $vm take "auto-$fecha" | Out-Null
        $snap = "auto-$fecha"
    } else { $snap = "-" }

    [PSCustomObject]@{
        VM       = $vm
        Estado   = $estado
        RAM_MB   = $ram
        CPUs     = $cpu
        Snapshot = $snap
        Fecha    = $fecha
    }
}

$archivo = "$carpeta\informe-$fecha.csv"
$informe | Export-Csv $archivo -NoTypeInformation -Encoding UTF8
$informe | Format-Table -AutoSize
Write-Host "Informe guardado en $archivo" -ForegroundColor Green
