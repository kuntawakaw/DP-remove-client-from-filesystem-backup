function Show-Title
{
write-host "=== Remove Clients from Backup spec ==="
write-host " "

}

function List-Cells
{if ($args.Count -gt 1) { Write-Host 'Only enter one filename'; exit }
if (-not($args)) {
    do { $args = Read-Host 'Please enter a file name' } 
    until (($args -split '\s+').Count -eq 1 -and ($args))
    }
if (Test-Path $args) {
    $text = @(Get-Content $args)
    $newtext = New-Object System.Collections.ArrayList
    for ($i=0;$i -lt $text.count; $i ++) { $newtext += "$($i + 1): " + $text[$i] }
    $newtext
    }
else { Write-Host "$args does not exist" -ForegroundColor Red }
write-host " "

}


function Select-Site
{
    Write-Host "Select Cells category"
    Write-Host " "
    Write-Host "N: HPQ NG2 Cells."
    Write-Host "P: HPQ NG1 Cells"
    Write-Host "R: Remote Sites"
    Write-Host "E: Entsvcs cells"
    Write-Host "S: Softwaregrp cells"
    Write-Host " "
$inputsite = Read-Host "Please Select Cell category"
switch ($inputsite)
    {
    'N'{
    Write-Host " "
    Write-Host "================== NGDC ====================="
    List-Cells .\cells.txt
    $cellnum = Read-Host -Prompt 'Select Cell Server'
    Write-Host " "
    $script:cellname = (gc cells.txt)[$cellnum -1 ]
    write-host "======= $cellname ======="
    }
    'P'{
    Write-Host " "
    Write-Host "================== NGDC ====================="
    List-Cells .\cells-MCS.txt
    $cellnum = Read-Host -Prompt 'Select Cell Server'
    Write-Host " "
    $script:cellname = (gc cells-MCS.txt)[$cellnum -1 ]
    write-host "======= $cellname ======="
    }
    'R'{
    Write-Host " "
    Write-Host "============== RCS/MCS Cells ================"
    List-Cells .\cells-RCS.txt
    $cellnum = Read-Host -Prompt 'Select Cell Server'
    write-host " "
    $script:cellname = (gc cells-RCS.txt)[$cellnum -1 ]
    write-host "======= $cellname ======="
    }
    'E'{
    Write-Host " "
    Write-Host "============== RCS/MCS Cells ================"
    List-Cells .\cells-entsvcs.txt
    $cellnum = Read-Host -Prompt 'Select Cell Server'
    write-host " "
    $script:cellname = (gc cells-entsvcs.txt)[$cellnum -1 ]
    write-host "======= $cellname ======="
    }
    'S'{
    Write-Host " "
    Write-Host "============== RCS/MCS Cells ================"
    List-Cells .\cells-softwaregrp.txt
    $cellnum = Read-Host -Prompt 'Select Cell Server'
    write-host " "
    $script:cellname = (gc cells-softwaregrp.txt)[$cellnum -1 ]
    write-host "======= $cellname ======="
    }
    'q' {
    return
    }
    }
}

function Provide-Client
{
    Write-host "Please enter Client Name (no FQDN)"
    $client1 = Read-host -Prompt "Client 1 "
    if ($client1) { $client2 = Read-Host -Prompt "Client 2 " ; $clientnum = 1 }
    if ($client2) { $client3 = Read-Host -Prompt "Client 3 " ; $clientnum = 2 }
    if ($client3) { $client4 = Read-Host -Prompt "Client 4 " ; $clientnum = 3 }
    if ($client4) { $client5 = Read-Host -Prompt "Client 5 " ; $clientnum = 4 }
    if ($client5) { $clientnum = 5}
    }

function prepare-cmd
{ 
if ( $clientnum -eq 1 ) { Add-Content -Value " grep $client1" -path ./rmvcmd.txt }
elseif ($clientnum -eq 2 ) { Add-Content -Value " grep $client1" -path ./rmvcmd.txt }


do
{ 
    cls
    Show-Title
    Select-Site
    Provide-Client
    pause
}
until ($input -eq 'q')
