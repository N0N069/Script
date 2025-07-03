[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true)]
    [string]$ServiceCible
)

$OutputEncoding = [Console]::OutputEncoding = [Text.Encoding]::UTF8

$donnees = Import-Csv "./employes.csv"
foreach ($e in $donnees) {
    $e.Age = [int]$e.Age
    $e.Salaire = [decimal]$e.Salaire
}
Set-Variable -Name "donnees" -Value $donnees -Scope Global -Force

$donnees | Select-Object -First 2

$donnees | ForEach-Object { $_.Nom }
($donnees | Measure-Object -Property Age -Average).Average
$donnees | Where-Object { $_.Service -eq "Informatique" }

$donnees | Where-Object { $_.Age -gt 40 }
foreach ($e in $donnees) {
    $age = $e.Age
    $evaluation = if ($age -lt 35) {
        "Jeune"
    } elseif ($age -lt 50) {
        "Expérimenté"
    } else {
        "Senior"
    }
    "$($e.Nom) : $evaluation"
}

foreach ($e in $donnees) {
    "$($e.Nom) travaille dans le service $($e.Service) avec un salaire de $($e.Salaire) €"
}
for ($i = 0; $i -lt 3 -and $i -lt $donnees.Count; $i++) {
    $donnees[$i].Nom
}

foreach ($e in $donnees) {
    $categorie = switch ($e.Service) {
        "Informatique" { "Technique"; break }
        "RH" { "Support"; break }
        "Comptabilité" { "Support"; break }
        "Marketing" { "Client"; break }
        default { "Autre" }
    }
    "$($e.Nom) → $categorie"
}

$donnees.Count
($donnees | Measure-Object -Property Salaire -Average).Average
$donnees | Sort-Object {[decimal]$_.Salaire} -Descending | Select-Object -First 1 | ForEach-Object {
    "$($_.Nom) avec $($_.Salaire) €"
}


Function Calculer-RatioSalaire {
    Param(
        [Parameter(Mandatory=$true)]
        [decimal]$Salaire1,
        [Parameter(Mandatory=$true)]
        [decimal]$Salaire2
    )

    try {
        if ($Salaire2 -eq 0) {
            Write-Host "ATTENTION : Le deuxième salaire ne peut pas être zéro pour calculer un ratio." -ForegroundColor Yellow
            return $null
        }
        return $Salaire1 / $Salaire2
    }
    catch {
        Write-Host "Une erreur inattendue est survenue : $($_.Exception.Message)" -ForegroundColor Red
        return $null
    }
}

Import-Module (Join-Path $PSScriptRoot "EmployeTools.psm1") -Force

foreach ($employe in $donnees) {
    Afficher-Employe -Employe $employe
}

foreach ($employe in $donnees) {
    Afficher-Employe -Employe $employe -Prefix "[Infos Employé]"
}

$ratioValide = Calculer-RatioSalaire -Salaire1 5000 -Salaire2 2500
if ($ratioValide -ne $null) { Write-Host "Ratio 5000/2500 : $ratioValide" }

$ratioErreur = Calculer-RatioSalaire -Salaire1 5000 -Salaire2 0
if ($ratioErreur -eq $null) { Write-Host "Le ratio n'a pas pu être calculé pour la division par zéro." }

$employesInfo = Filtrer-Employes -Service "Informatique"
$employesInfo | ForEach-Object { $_.Nom }

$employesMarketing = Filtrer-Employes -Service "Marketing"
$employesMarketing | ForEach-Object { $_.Nom }

$employesFiltres = Filtrer-Employes -Service $ServiceCible
Write-Host "`n--- Rapport final pour le service '$ServiceCible' ---"
if ($employesFiltres.Count -eq 0) {
    Write-Host "Aucun employé trouvé pour le service '$ServiceCible'."
} else {
    foreach ($employe in $employesFiltres) {
        Afficher-Employe -Employe $employe -Prefix "[Employé]"
    }
}
