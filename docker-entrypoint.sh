#!/bin/bash
# ============================================================
#  docker-entrypoint.sh — iDempiere release-12
#  Injecte la config DB dans idempiereEnv.properties au démarrage
# ============================================================

set -e

log() { echo "[entrypoint] $*"; }

ENV_FILE="${IDEMPIERE_HOME}/idempiereEnv.properties"

# ── Injection config DB ───────────────────────────────────
if [ -f "${ENV_FILE}" ]; then
    log "Injection config DB dans idempiereEnv.properties"

    [ -n "${DB_HOST}" ]     && sed -i "s|^ADEMPIERE_DB_SERVER=.*|ADEMPIERE_DB_SERVER=${DB_HOST}|"     "${ENV_FILE}"
    [ -n "${DB_PORT}" ]     && sed -i "s|^ADEMPIERE_DB_PORT=.*|ADEMPIERE_DB_PORT=${DB_PORT}|"         "${ENV_FILE}"
    [ -n "${DB_NAME}" ]     && sed -i "s|^ADEMPIERE_DB_NAME=.*|ADEMPIERE_DB_NAME=${DB_NAME}|"         "${ENV_FILE}"
    [ -n "${DB_USER}" ]     && sed -i "s|^ADEMPIERE_DB_USER=.*|ADEMPIERE_DB_USER=${DB_USER}|"         "${ENV_FILE}"
    [ -n "${DB_PASSWORD}" ] && sed -i "s|^ADEMPIERE_DB_PASSWORD=.*|ADEMPIERE_DB_PASSWORD=${DB_PASSWORD}|" "${ENV_FILE}"

    log "Config appliquée : ${DB_HOST}:${DB_PORT}/${DB_NAME} (user: ${DB_USER})"
else
    log "WARN: idempiereEnv.properties introuvable à ${ENV_FILE}"
    log "      Démarrage avec la configuration par défaut du build"
fi

# ── Démarrage iDempiere ───────────────────────────────────
log "Démarrage iDempiere (JAVA_OPTS=${JAVA_OPTS})"
exec ${IDEMPIERE_HOME}/idempiere "$@"
