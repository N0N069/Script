# Étape 1 — Chargement des données
$donnees = Import-Csv "./employes.csv"
$OutputEncoding = [Console]::OutputEncoding = [Text.Encoding]::UTF8
foreach ($e in $donnees) {
    $e.Age = [int]$e.Age
    $e.Salaire = [decimal]$e.Salaire
}
$donnees | Select-Object -First 2

# Étape 2 — Exploration et accès aux attributs
$donnees | ForEach-Object { $_.Nom }
($donnees | Measure-Object -Property Age -Average).Average
$donnees | Where-Object { $_.Service -eq "Informatique" }

# Étape 3 — Utilisation de conditions
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

# Étape 4 — Boucles
foreach ($e in $donnees) {
    "$($e.Nom) travaille dans le service $($e.Service) avec un salaire de $($e.Salaire) €"
}
for ($i = 0; $i -lt 3 -and $i -lt $donnees.Count; $i++) {
    $donnees[$i].Nom
}

# Étape 5 — Switch
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

# Étape 6 — Rapport final
$donnees.Count
($donnees | Measure-Object -Property Salaire -Average).Average
$donnees | Sort-Object {[decimal]$_.Salaire} -Descending | Select-Object -First 1 | ForEach-Object {
    "$($_.Nom) avec $($_.Salaire) €"
}
