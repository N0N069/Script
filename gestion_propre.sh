#!/bin/bash
set -euo pipefail

LOG_FILE="activity.log"
ERROR_LOG="error.log"
VERBOSE_LEVEL=1

compteur=0

log_message() {
  local type="$1"
  local message="$2"
  local timestamp
  timestamp=$(date +"%Y-%m-%d %H:%M:%S")

  case "$type" in
    "info")
      if (( VERBOSE_LEVEL >= 1 )); then
        echo "[$timestamp] INFO: $message" | tee -a "$LOG_FILE"
      fi
      ;;
    "success")
      if (( VERBOSE_LEVEL >= 1 )); then
        echo "[$timestamp] SUCCESS: $message" | tee -a "$LOG_FILE"
      fi
      ;;
    "verbose")
      if (( VERBOSE_LEVEL >= 2 )); then
        echo "[$timestamp] VERBOSE: $message" | tee -a "$LOG_FILE"
      fi
      ;;
    "error")
      echo "[$timestamp] ERROR: $message" | tee -a "$ERROR_LOG" >&2
      ;;
    *)
      echo "[$timestamp] UNKNOWN LOG TYPE: $message" | tee -a "$ERROR_FILE" >&2
      ;;
  esac
}

display_menu() {
  log_message "verbose" "Affichage du menu principal."
  echo "==== Gestionnaire de Fichiers ===="
  echo "1) Lister fichiers"
  echo "2) Créer fichier"
  echo "3) Supprimer fichier"
  echo "4) Afficher contenu fichier"
  echo "5) Quitter"
  echo "=================================="
}

list_files() {
  log_message "info" "Tentative de listage des fichiers."
  if ! ls -F ; then
    log_message "error" "Impossible de lister les fichiers."
    return 1
  fi
  ((compteur++))
  log_message "success" "Liste des fichiers affichée."
  return 0
}

create_file() {
  read -rp "Nom du fichier à créer : " nom
  log_message "info" "Demande de création du fichier: '$nom'."

  if [[ -z "$nom" ]]; then
    log_message "error" "Nom de fichier vide non autorisé."
    return 1
  fi

  if [[ -e "$nom" ]]; then
    log_message "error" "Le fichier '$nom' existe déjà. Annulation de la création."
    return 1
  fi

  if ! touch "$nom"; then
    log_message "error" "Échec de la création du fichier '$nom'."
    return 1
  fi

  ((compteur++))
  log_message "success" "Fichier '$nom' créé avec succès."
  return 0
}

delete_file() {
  read -rp "Nom du fichier à supprimer : " nom
  log_message "info" "Demande de suppression du fichier: '$nom'."

  if [[ -z "$nom" ]]; then
    log_message "error" "Nom de fichier vide non autorisé."
    return 1
  fi

  if [[ ! -f "$nom" ]]; then
    log_message "error" "Le fichier '$nom' est introuvable ou n'est pas un fichier régulier. Annulation de la suppression."
    return 1
  fi

  if ! rm "$nom"; then
    log_message "error" "Échec de la suppression du fichier '$nom'."
    return 1
  fi

  ((compteur++))
  log_message "success" "Fichier '$nom' supprimé avec succès."
  return 0
}

display_file_content() {
  read -rp "Nom du fichier à afficher : " nom
  log_message "info" "Demande d'affichage du contenu du fichier: '$nom'."

  if [[ -z "$nom" ]]; then
    log_message "error" "Nom de fichier vide non autorisé."
    return 1
  fi

  if [[ ! -f "$nom" ]]; then
    log_message "error" "Le fichier '$nom' est introuvable ou n'est pas un fichier régulier. Annulation de l'affichage."
    return 1
  fi

  log_message "verbose" "Affichage du contenu de '$nom' :"
  if ! cat "$nom"; then
    log_message "error" "Échec de l'affichage du contenu du fichier '$nom'."
    return 1
  fi
  ((compteur++))
  log_message "success" "Contenu du fichier '$nom' affiché."
  return 0
}

log_message "info" "Script de gestion de fichiers lancé."

while true; do
  display_menu
  read -rp "Votre choix : " choix

  case "$choix" in
    1) list_files ;;
    2) create_file ;;
    3) delete_file ;;
    4) display_file_content ;;
    5)
      log_message "info" "Demande de sortie. Total des actions réussies: $compteur."
      echo "Total des actions réussies : $compteur"
      log_message "success" "Fermeture du script."
      exit 0
      ;;
    *)
      log_message "error" "Choix '$choix' invalide. Veuillez sélectionner une option valide (1-5)."
      echo "Choix invalide. Veuillez réessayer."
      ;;
  esac
  echo
done
