Function Afficher-Employe {
    Param(
        [Parameter(Mandatory=$true)]
        [PSCustomObject]$Employe,

        [string]$Prefix = ""
    )
    if (-not [string]::IsNullOrEmpty($Prefix)) {
        Write-Host "$Prefix " -NoNewline
    }
    Write-Host "Nom: $($Employe.Nom), Service: $($Employe.Service), Salaire: $($Employe.Salaire) €"
}

Function Filtrer-Employes {
    Param(
        [Parameter(Mandatory=$true)]
        [string]$Service
    )
    Get-Variable -Name "donnees" -Scope Global -ErrorAction SilentlyContinue | ForEach-Object {
        $_.Value | Where-Object { $_.Service -eq $Service }
    }
}

Export-ModuleMember -Function Afficher-Employe, Filtrer-Employes
