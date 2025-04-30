#!/bin/bash

compteur=0

if [[ "$1" == "-v" || "$1" == "--version" ]]; then
  echo "Version 1.0"
  exit 0
fi

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  echo "Script de gestion de fichiers"
  echo "Options : -v (version), -h (aide)"
  exit 0
fi

while true; do
  echo "Menu :"
  echo "1) Lister fichiers"
  echo "2) Créer fichier"
  echo "3) Supprimer fichier"
  echo "4) Afficher fichier"
  echo "5) Quitter"
  read -p "Choix : " choix

  case "$choix" in
    1)
      ls
      ((compteur++))
      echo "Liste enregistrée dans log.txt" >> log.txt
      ;;
    2)
      read -p "Nom du fichier : " nom
      if [ -e "$nom" ]; then
        echo "Déjà existant"
      else
        touch "$nom"
        echo "Fichier créé"
        ((compteur++))
        echo "Création de $nom" >> log.txt
      fi
      ;;
    3)
      read -p "Nom du fichier : " nom
      if [ -f "$nom" ]; then
        rm "$nom"
        echo "Supprimé"
        ((compteur++))
        echo "Suppression de $nom" >> log.txt
      else
        echo "Fichier introuvable"
      fi
      ;;
    4)
      read -p "Nom du fichier : " nom
      if [ -f "$nom" ]; then
        cat "$nom"
        ((compteur++))
        echo "Affichage de $nom" >> log.txt
      else
        echo "Fichier introuvable"
      fi
      ;;
    5)
      echo "Total actions : $compteur"
      echo "Fermeture du script" >> log.txt
      exit 0
      ;;
    *)
      echo "Mauvais choix"
      ;;
  esac
  echo
done
