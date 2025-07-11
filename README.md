# Projet Python Structuré

Ce projet est un exemple de structure de projet Python, incluant l'organisation des fichiers, des fonctions utilitaires, un menu interactif en ligne de commande (CLI) et la gestion des dépendances avec Poetry.

## Objectif du script

L'objectif principal de ce script est de démontrer :
- Une structure de projet Python propre.
- L'utilisation de fonctions utilitaires modulaires.
- La création d'un CLI interactif avec la bibliothèque `click`.
- La gestion des environnements virtuels et des dépendances avec `Poetry`.
- L'implémentation de décorateurs Python.

Le script propose trois commandes principales :
1. **`capitalize <texte>`** : Met en majuscules toutes les lettres du texte fourni.
2. **`sum-numbers <nombres...>`** : Calcule la somme d'une liste de nombres.
3. **`run-decorated [--message <msg>]`** : Exécute une fonction décorée pour illustrer le concept de décorateur.

## Installation et exécution

Suivez les étapes ci-dessous pour installer l'environnement et exécuter le script.

### 1. Cloner le dépôt (si applicable)

Si ce projet est hébergé dans un dépôt, clonez-le :

```bash
git clone <URL_DU_DEPOT>
cd <NOM_DU_DOSSIER_DU_PROJET>