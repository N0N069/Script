#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

LOG="log.txt"
ERRLOG="error.log"
VERBOSE=0
ACTIONS=0

log() {
  local level="$1" msg="$2"
  [[ $level == "INFO" && $VERBOSE -ge 1 ]] && echo "$msg"
  [[ $level == "DEBUG" && $VERBOSE -ge 2 ]] && echo "[DEBUG] $msg"
  [[ $level == "INFO" ]] && echo "[INFO] $(date) - $msg" >> "$LOG"
  [[ $level == "ERROR" ]] && { echo "[ERROR] $(date) - $msg" >> "$ERRLOG"; echo "Erreur : $msg" >&2; }
}

help() {
  echo "Utilisation : $0 [-v|-vv|--help|--version]"
}

# Parse arguments
for arg in "$@"; do
  case "$arg" in
    -v) VERBOSE=1 ;;
    -vv) VERBOSE=2 ;;
    --help) help; exit 0 ;;
    --version) echo "Version 2.0"; exit 0 ;;
    *) log ERROR "Option invalide : $arg"; help; exit 1 ;;
  esac
done

log INFO "---- Nouvelle session ----"

while true; do
  echo "Menu :"
  echo "1) Lister fichiers"
  echo "2) Créer fichier"
  echo "3) Supprimer fichier"
  echo "4) Afficher fichier"
  echo "5) Quitter"
  read -rp "Choix : " choix

  case "$choix" in
    1)
      ls
      log INFO "Liste des fichiers affichée"
      ((ACTIONS++))
      ;;
    2)
      read -rp "Nom : " f
      [[ -z "$f" ]] && log ERROR "Nom vide" && continue
      if [[ -e "$f" ]]; then
        echo "Déjà existant"; log INFO "Création refusée pour '$f'"
      else
        touch "$f"
        echo "Créé"; log INFO "Fichier '$f' créé"; ((ACTIONS++))
      fi
      ;;
    3)
      read -rp "Nom : " f
      [[ -z "$f" ]] && log ERROR "Nom vide" && continue
      if [[ -f "$f" ]]; then
        rm "$f"
        echo "Supprimé"; log INFO "Fichier '$f' supprimé"; ((ACTIONS++))
      else
        echo "Introuvable"; log ERROR "Suppression échouée pour '$f'"
      fi
      ;;
    4)
      read -rp "Nom : " f
      [[ -z "$f" ]] && log ERROR "Nom vide" && continue
      if [[ -f "$f" ]]; then
        cat "$f"; log INFO "Fichier '$f' affiché"; ((ACTIONS++))
      else
        echo "Introuvable"; log ERROR "Affichage échoué pour '$f'"
      fi
      ;;
    5)
      echo "Actions totales : $ACTIONS"
      log INFO "Session terminée avec $ACTIONS action(s)"
      exit 0
      ;;
    *) echo "Mauvais choix"; log ERROR "Choix invalide : $choix" ;;
  esac
  echo
done
